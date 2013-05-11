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
        
        // Settings for our OBD2 devices
        [self._scanTool setHost:@"192.168.0.10"];
        [self._scanTool setPort:35000];
    }
    return self;
}

- (void) startCollection {
    [super startCollection];
    [self._scanTool startScan];
}

-(void) stopCollection {
    [self._scanTool cancelScan];
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
                                          [NSNumber numberWithInt:0x0D], // Vehicle speed
                                          //[NSNumber numberWithInt:0x2F], // Fuel level -- FLKit alt code
                                          //[NSNumber numberWithInt:0x0A], // Engine fuel pressure - FLKit code
                                          [NSNumber numberWithInt:0x10], // mass air flow, for instant MPG -- THIS CODE FROM FLKit
                                          //[NSNumber numberWithInt:0x31], // distance since codes cleared. for relative dist - FLKit code
									 nil]];
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveResponse:(NSArray*)responses {
	
	FLECUSensor* sensor	= nil;
	
	for (FLScanToolResponse* response in responses) {
		
		sensor = [FLECUSensor sensorForPID:response.pid];
		[sensor setCurrentResponse:response];
        
        //[DreiCarCenter debug:[NSString stringWithFormat:@"Received Response %p val %@",response.pid, [sensor valueForMeasurement1:NO]] from:@"OBD2" jsonMessage:false];
        
        if ([sensor valueForMeasurement1:YES] == nil) {
            return;
        }

        NSNumber *dp = [[NSNumber alloc] init];
        dp = [sensor valueForMeasurement1:YES];
        
		if (response.pid == 0x0C) {
			[self._currentValues setObject:dp forKey:@"rpm"];
		}
		else if (response.pid == 0x0D) {
			[self._currentValues setObject:dp forKey:@"vehicle_speed"];
		}
        else if (response.pid == 0x10) {
            [self._currentValues setObject:dp forKey:@"mass_air_flow"];
            //NSLog(@"MAF: %f",[dp doubleValue]);
        }
	}
}

- (NSMutableDictionary *) processDataPoint:(NSMutableDictionary *)data {
    // need to check if a new data point actually came in
    // get the MAF and then delete it (not used in the returned DP)
    NSNumber *mass_air_flow = [data objectForKey:@"mass_air_flow"];
    [data removeObjectForKey:@"mass_air_flow"];
    
    // calculate instant MPG
    NSNumber *mph = [data objectForKey:@"vehicle_speed"];
    NSNumber *mpg = [NSNumber numberWithDouble: [DreiSynchDataProvider_OBD2 calcInstantMPG:[mph doubleValue] airFlow:[mass_air_flow doubleValue]]]; 
    //NSLog(@"MPG: %f", [mpg doubleValue]);
    [data setObject:mpg forKey:@"instant_mpg"];
    
    CLLocation *loc = [self._scanTool currentLocation];

    [data setObject:[NSNumber numberWithDouble:loc.coordinate.latitude] forKey:@"gps_latitude"];
    [data setObject:[NSNumber numberWithDouble:loc.coordinate.longitude] forKey:@"gps_longitude"];
    
    
    return data;
    }

/* Adopted straight from FLECU code... no idea how it works or what these magic constants are */
+(double) calcInstantMPG:(double) kph airFlow:(double) maf {
    
	if(kph > 255) {
		kph = 255;
	}
    
	if(kph < 0) {
		kph = 0;
	}
    
    
	if(maf <= 0) {
		maf = 0.1;
	}
	
	return ((14.7 * 6.17 * 454.0 * kph * 0.621371) / (3600.0 * maf));
}

@end
