//
//  DreiCarCenter.m
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import "DreiCarCenter.h"
#import "DreiSynchDataProvider_OBD2.h"

@implementation DreiCarCenter

# pragma mark Singleton constructor

static DreiCarCenter *gInstance = NULL;
//DreiSmartSend * smartSend;

+ (DreiCarCenter *)instance {
    @synchronized(self)
    {
        if (gInstance == NULL) {
            gInstance = [[self alloc] init];
        }
    }
    
    return gInstance;
}

# pragma mark Low-level methods

-(id)init {
    self = [super init];
    /* @trusheim you should probably check out where this should go */
    //smartSend = [[DreiSmartSend alloc] init];
    //[smartSend start];
    return self;
}

-(BOOL)hasDataService {
    if (self.dataService != nil) {
        return true;
    }
    return false;
}

-(DreiSynchDataProvider *)getDataService {
    if (![self hasDataService]) {
        self.dataService = [[DreiSynchDataProvider_OBD2 alloc] init];
    }
    return self.dataService;
}

- (void)updateConnectionStatus:(NSString *)status {
    [self sendMessage:status toCallback:@"connectionStatus"];
}

-(BOOL)hasConnectEndpoint {
    return (self.connectEndpoint != nil);
}

- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback {
    if (self.connectEndpoint == NULL) return false;
    [self.connectEndpoint sendMessage:status toCallback:callback];
    return true;
}

- (BOOL)sendDebugMessage:(NSString *)message fromComponent:(NSString *)component isJson:(BOOL)isJson {
    if (self.connectEndpoint == NULL) return false;
    [self.connectEndpoint sendDebugMessage:message fromComponent:component isJson:isJson];
    return true;
}

-(void)updateDriveLogStatus:(BOOL)logging {
    if (logging) {
        [self sendMessage:@"on" toCallback:@"driveLog"];
        //[bmwUIEndpoint externalLogUpdate:@"logOn"];
    } else {
        [self sendMessage:@"off" toCallback:@"driveLog"];
        //[bmwUIEndpoint externalLogUpdate:@"logOff"];
    }
}

/*-(void)setBMWUIEndpoint:(id)pdEndpointClass {
    bmwUIEndpoint = pdEndpointClass;
}*/


/*- (BOOL) driveLog_uploadDataRaw {
    [DreiCarCenter debug:@"Data upload started" from:@"CarCenter" jsonMessage:false];
    DreiUploader *uploader = [[DreiUploader alloc] init];
    return [uploader formatAndPost:[[self getDDS] getData]
                             toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/rawcardata/update"]
                             error:nil
     ]; //TODO: Use manifest
    [DreiCarCenter debug:@"Data uploaded" from:@"CarCenter" jsonMessage:false];

}*/
/*
- (BOOL) driveLog_uploadCommuteLog {
    DreiUploader *uploader = [[DreiUploader alloc] init];
    return [uploader formatAndPost:[[self getDDS] getData]
                             toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/commutelog/update"]
                             error:nil
     ]; //TODO: Use manifest
}*/

- (BOOL) driveLog_clearData {
    [[self getDataService] clearStoredData];
    return true;
}

- (BOOL) driveLog_startCollection {
    [[self getDataService] startCollection];
    [self updateDriveLogStatus:true];
    [DreiCarCenter debug:@"Car logging started" from:@"CarCenter" jsonMessage:false];

    return true;
}

- (BOOL) driveLog_stopCollection {
    [[self getDataService] stopCollection];
    [self updateDriveLogStatus:false];
    [DreiCarCenter debug:@"Car logging stopped" from:@"CarCenter" jsonMessage:false];

    return true;
}

- (NSString *)driveLog_getStatisticsJSON {
    NSDictionary *stats = [[self getDataService] getStatistics];
    NSData *data = [NSJSONSerialization dataWithJSONObject:stats
                                                   options:0
                                                     error:nil];
    NSString *jsonString = [[NSString alloc]
                            initWithData:data
                            encoding:NSUTF8StringEncoding];
    return jsonString;
    
}

-(void) driveLog_updateData:(NSDictionary *)dataPoint {
    NSString *jsonData = [[NSString alloc]
                          initWithData:[DreiCarCenter formatDataEntry:dataPoint error:nil]
                          encoding:NSUTF8StringEncoding];
    [[self connectEndpoint] sendMessage:jsonData toCallback:@"dataEntry" isJson:TRUE];
}

+(void) debug:(NSString *)message from:(NSString *)from jsonMessage:(BOOL)isJson {
    [[self instance] sendDebugMessage:message fromComponent:from isJson:isJson];
    NSLog(@"(%@) %@", from, message);
}

+ (NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error {
    return [NSJSONSerialization dataWithJSONObject:originalDataPoint
                                           options:0
                                             error:&error];
}


@end
