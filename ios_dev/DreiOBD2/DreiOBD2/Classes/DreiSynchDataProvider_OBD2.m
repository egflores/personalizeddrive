//
//  DreiSynchDataProvider_OBD2.m
//  BasicScan
//
//  Created by Stephen Trusheim on 4/29/13.
//
//

#import "DreiSynchDataProvider_OBD2.h"
#import "DataPoint.h"
#import "FLLogging.h"
#import "FLECUSensor.h"

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
}

- (void)scanDidPause:(FLScanTool*)scanTool {
	FLINFO(@"PAUSED SCAN")
}

- (void)scanDidCancel:(FLScanTool*)scanTool {
	FLINFO(@"CANCELLED SCAN")
}

- (void)scanToolDidConnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL CONNECTED")
}

- (void)scanToolDidDisconnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL DISCONNECTED")
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
}

- (void)scanTool:(FLScanTool*)scanTool didSendCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID SEND COMMAND")
}

- (void)scanToolDidFailToInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION FAILURE")
	FLDEBUG(@"scanTool.scanToolState: %@", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
}


- (void)scanToolDidInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION COMPLETE")
	FLDEBUG(@"scanTool.scanToolState: %08X", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
	
	[self._scanTool setSensorScanTargets:[NSArray arrayWithObjects:
                                          [NSNumber numberWithInt:0x0C], // Engine RPM
                                          [NSNumber numberWithInt:0x0D], // Vehicle speed
                                          [NSNumber numberWithInt:0x2F], // Fuel level
                                          [NSNumber numberWithInt:0x5E], // Engine fuel rate
                                          [NSNumber numberWithInt:0x66], // mass air flow, for instant MPG
                                          [NSNumber numberWithInt:0x31], // distance since codes cleared. for relative dist
									 nil]];
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveResponse:(NSArray*)responses {
	FLINFO(@"DID RECEIVE RESPONSE")
	
	FLECUSensor* sensor	= nil;
	
	for (FLScanToolResponse* response in responses) {
		
		sensor = [FLECUSensor sensorForPID:response.pid];
		[sensor setCurrentResponse:response];
		
        DataPoint *dp = [[DataPoint alloc] init];
        dp.data = [sensor valueForMeasurement1:NO];
        dp.unitStr = [sensor imperialUnitString];
        
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
    
    // get the MAF and then delete it (not used in the returned DP)
    DataPoint *mass_air_flow = [data objectForKey:@"mass_air_flow"];
    [data delete:@"mass_air_flow"];
    
    // calculate instant MPG
    DataPoint *mph = [data objectForKey:@"vehicle_speed"];
    DataPoint *mpg = [[DataPoint alloc] init];
    mpg.data = [NSNumber numberWithDouble: [DreiSynchDataProvider_OBD2 calcInstantMPG:[mph.data doubleValue] airFlow:[mass_air_flow.data doubleValue]]];
    mpg.unitStr = @"miles/gal";
    [data setObject:mpg forKey:@"instant_mpg"];
    
    // calculate relative distance (TODO)
    DataPoint *d_cleared = [data objectForKey:@"d_cleared"];
    [data delete:@"d_cleared"];
    
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
