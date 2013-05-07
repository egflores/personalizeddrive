//
//  DreiSynchDataProvider_OBD2.m
//  BasicScan
//
//  Created by Stephen Trusheim on 4/29/13.
//
//

#import "DreiSynchDataProvider_OBD2.h"
#import "FLLogging.h"
#import "FLECUSensor.h"
#import "DreiCarCenter.h"

@implementation DreiSynchDataProvider_OBD2

- (id) init {
    if (self = [super init]) {
        NSLog(@"Initializing scan tool");
        
        self._scanTool = [FLScanTool scanToolForDeviceType:kScanToolDeviceTypeELM327];
        
        self._scanTool.useLocation= YES;
        self._scanTool.delegate	= self;
        
        if(self._scanTool.isWifiScanTool ) {
            // These are the settings for the PLX Kiwi WiFI, your Scan Tool may
            // require different.
            [self._scanTool setHost:@"192.168.0.10"];
            [self._scanTool setPort:35000];
        }
    }
    return self;
}

- (void) startCollection {
    [super startCollection];
    [self._scanTool startScan];
}

-(void) stopCollection {
    if(self._scanTool.isWifiScanTool) {
		[self._scanTool cancelScan];
	}
	
	self._scanTool.sensorScanTargets = nil;
	self._scanTool.delegate	= nil;
}


- (void)scanDidStart:(FLScanTool*)scanTool {
	FLINFO(@"STARTED SCAN")
    [[DreiCarCenter instance] updateConnectionStatus:@"scanning"];
}

- (void)scanDidPause:(FLScanTool*)scanTool {
	FLINFO(@"PAUSED SCAN")
    [[DreiCarCenter instance] updateConnectionStatus:@"initializing"];
}

- (void)scanDidCancel:(FLScanTool*)scanTool {
	FLINFO(@"CANCELLED SCAN")
    [[DreiCarCenter instance] updateConnectionStatus:@"initializing"];

}

- (void)scanToolDidConnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL CONNECTED")
    [[DreiCarCenter instance] updateConnectionStatus:@"connected"];
}

- (void)scanToolDidDisconnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL DISCONNECTED")
    [[DreiCarCenter instance] updateConnectionStatus:@"disconnected"];
}


- (void)scanToolWillSleep:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL SLEEP")
}

- (void)scanTool:(FLScanTool*)scanTool didReceiveVoltage:(NSString*)voltage {
	FLTRACE_ENTRY
}


- (void)scanTool:(FLScanTool*)scanTool didTimeoutOnCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID TIMEOUT")
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveError:(NSError*)error {
	FLINFO(@"DID RECEIVE ERROR")
	FLNSERROR(error)
    [[DreiCarCenter instance] updateConnectionStatus:@"error"];
}

- (void)scanTool:(FLScanTool*)scanTool didSendCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID SEND COMMAND")
}

- (void)scanToolDidFailToInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION FAILURE")
	FLDEBUG(@"scanTool.scanToolState: %@", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
    [[DreiCarCenter instance] updateConnectionStatus:@"error"];

}


- (void)scanToolDidInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION COMPLETE")
	FLDEBUG(@"scanTool.scanToolState: %08X", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
	
	[self._scanTool setSensorScanTargets:[NSArray arrayWithObjects:
                                          [NSNumber numberWithInt:0x0C], // Engine RPM
                                          //[NSNumber numberWithInt:0x0D], // Vehicle speed
                                          //[NSNumber numberWithInt:0x2F], // Fuel level -- FLKit alt code
                                          //[NSNumber numberWithInt:0x0A], // Engine fuel pressure - FLKit code
                                          //[NSNumber numberWithInt:0x10], // mass air flow, for instant MPG -- THIS CODE FROM FLKit
                                          [NSNumber numberWithInt:0x31], // distance since codes cleared. for relative dist - FLKit code
									 nil]];
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveResponse:(NSArray*)responses {
	
	FLECUSensor* sensor	= nil;
	
	for (FLScanToolResponse* response in responses) {
		
		sensor = [FLECUSensor sensorForPID:response.pid];
		[sensor setCurrentResponse:response];
        
        [DreiCarCenter debug:[NSString stringWithFormat:@"Received Response %p val %@",response.pid, [sensor valueForMeasurement1:NO]] from:@"OBD2" jsonMessage:false];
        
        if ([sensor valueForMeasurement1:NO] == nil) {
            return;
        }

        NSMutableDictionary *dp = [[NSMutableDictionary alloc] init];
        [dp setObject:[sensor valueForMeasurement1:NO] forKey:@"data"];
        if ([sensor imperialUnitString] != nil) {
            [dp setObject:[sensor imperialUnitString] forKey:@"unit"];
        } else {
            [dp setObject:@"none" forKey:@"unit"];
        }
        
		if (response.pid == 0x0C) {
			[self._currentValues setObject:dp forKey:@"rpm"];
		}
		else if (response.pid == 0x0D) {
			[self._currentValues setObject:dp forKey:@"vehicle_speed"];
		}
        else if (response.pid == 0x5E) {
            [self._currentValues setObject:dp forKey:@"engine_fuel_rate"];
        }
        else if (response.pid == 0x2F) {
            [self._currentValues setObject:dp forKey:@"fuel_level"];
        }
        else if (response.pid == 0x66) {
            [self._currentValues setObject:dp forKey:@"mass_air_flow"];
        }
        else if (response.pid == 0x31) {
            [self._currentValues setObject:dp forKey:@"d_cleared"];
        }
	}
}

- (NSMutableDictionary *) processDataPoint:(NSMutableDictionary *)data {
    
    return data;
    
    // get the MAF and then delete it (not used in the returned DP)
    NSMutableDictionary *mass_air_flow = [data objectForKey:@"mass_air_flow"];
    [data removeObjectForKey:@"mass_air_flow"];
    
    // calculate instant MPG
    NSMutableDictionary *mph = [data objectForKey:@"vehicle_speed"];
    NSMutableDictionary *mpg = [[NSMutableDictionary alloc] init];
    [mpg setObject:[NSNumber numberWithDouble: [DreiSynchDataProvider_OBD2 calcInstantMPG:[[mph objectForKey:@"data"] doubleValue] airFlow:[[mass_air_flow objectForKey:@"data"] doubleValue]]] forKey:@"data"];
    [mpg setObject:@"miles/gal" forKey:@"unit"];
    [data setObject:mpg forKey:@"instant_mpg"];
    
    // calculate relative distance (TODO)
    NSMutableDictionary *d_cleared = [data objectForKey:@"d_cleared"];
    [data removeObjectForKey:@"d_cleared"];
    
    return data;
    }

/* Adopted straight from FLECU code... no idea how it works or what these magic constants are */
+(double) calcInstantMPG:(double) mph airFlow:(double) maf {
    
	if(mph > 255) {
		mph = 255;
	}
    
	if(mph < 0) {
		mph = 0;
	}
    
    
	if(maf <= 0) {
		maf = 0.1;
	}
    
	double mpg	= 0.0;	
	mpg	= ((14.7 * 6.17 * 454 * mph) / (3600 * maf));
	
	return mpg;
}

@end
