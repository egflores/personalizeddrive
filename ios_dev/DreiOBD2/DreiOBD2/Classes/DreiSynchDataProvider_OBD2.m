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
    [super stopCollection];
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
            self._currentPoint.rpm = [dp doubleValue];
		}
		else if (response.pid == 0x0D) {
            self._currentPoint.kph = [dp doubleValue];
		}
        else if (response.pid == 0x10) {
            self._currentPoint.maf = [dp doubleValue];
            //NSLog(@"MAF: %f",[dp doubleValue]);
        }
	}
    
}

- (void) processCurrentPoint {
    CLLocation *loc = [self._scanTool currentLocation];
    
    self._currentPoint.gps_lat = loc.coordinate.latitude;
    self._currentPoint.gps_long = loc.coordinate.longitude;
}

@end
