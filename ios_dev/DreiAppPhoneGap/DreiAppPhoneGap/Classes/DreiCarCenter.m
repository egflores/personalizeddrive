//
//  DreiCarCenter.m
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import "DreiCarCenter.h"
#import "DreiDataService.h"
#import "DreiBMWDataService.h"
#import "DreiDebugDataService.h"

#import "DreiUploader.h"
#import <DreiDataService/DreiDataService.h>

@implementation DreiCarCenter

# pragma mark Singleton constructor

static DreiCarCenter *gInstance = NULL;
id bmwUIEndpoint;

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
    [TestClass Test];
    [TestClass Test];
    [TestClass Test];

    return self;
}

-(BOOL)hasDataService {
    if (self.manager && self.manager.application && self.manager.application.cdsService) return true;
    return false;
}

-(IDCdsService *)getDataService {
    if (![self hasDataService]) return nil;
    return self.manager.application.cdsService;
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

# pragma mark Application endpoints

-(void)updateCarConnectionStatus:(BOOL)carConnected {
    if (carConnected) {
        [self sendMessage:@"connected" toCallback:@"connection"];
        
        if ([self hasDataService]) {
            [self updateCarDataService:[self getDataService]];
        }
    } else {
        [self sendMessage:@"disconnected" toCallback:@"connection"];
    }
}

-(void)updateCarDataService:(IDCdsService *)newDataService {
    if ([self getDDS] != nil) {
        [[self getDDS] stopCollection];
        [[self getDDS] updateDataService:newDataService];
    }
    
    if (newDataService != nil) {
        [self sendMessage:@"hasDataService" toCallback:@"connection"];
    } else {
        [self sendMessage:@"noDataService" toCallback:@"connection"];
    }
}

-(void)updateCarLogging:(BOOL)logging {
    if (logging) {
        [self sendMessage:@"logOn" toCallback:@"carlogging"];
        [bmwUIEndpoint externalLogUpdate:@"logOn"];
    } else {
        [self sendMessage:@"logOff" toCallback:@"carlogging"];
        [bmwUIEndpoint externalLogUpdate:@"logOff"];
    }
}

-(void)setBMWUIEndpoint:(id)pdEndpointClass {
    bmwUIEndpoint = pdEndpointClass;
}

/* Car data log */

DreiDataService *d;

/* Only in here because we needed a singleton to handle grabbing the logger */
-(DreiDataService *)getDDS {
    if (d == nil) {
        d = [[[DreiBMWDataService alloc] initWithCDS:[self getDataService]] retain];
    }
    
    return d;
}

- (BOOL) driveLog_uploadDataRaw {
    [DreiCarCenter debug:@"Data upload started" from:@"CarCenter" jsonMessage:false];
    DreiUploader *uploader = [[DreiUploader alloc] init];
    return [uploader formatAndPost:[[self getDDS] getData]
                             toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/rawcardata/update"]
                             error:nil
     ]; //TODO: Use manifest
    [DreiCarCenter debug:@"Data uploaded" from:@"CarCenter" jsonMessage:false];

}
/*
- (BOOL) driveLog_uploadCommuteLog {
    DreiUploader *uploader = [[DreiUploader alloc] init];
    return [uploader formatAndPost:[[self getDDS] getData]
                             toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/commutelog/update"]
                             error:nil
     ]; //TODO: Use manifest
}*/

- (BOOL) driveLog_clearData {
    [[self getDDS] clearData];
    return true;
}

- (BOOL) driveLog_startCollection {
    if (![self hasDataService]) {
        [DreiCarCenter debug:@"Cannot start data collection" from:@"CarCenter" jsonMessage:false];
        return false;
    }
    
    [[self getDDS] startCollection];
    [self updateCarLogging:true];
    [DreiCarCenter debug:@"Car logging started" from:@"CarCenter" jsonMessage:false];

    return true;
}

- (BOOL) driveLog_stopCollection {
    [[self getDDS] stopCollection];
    [self updateCarLogging:false];
    [DreiCarCenter debug:@"Car logging stopped" from:@"CarCenter" jsonMessage:false];

    return true;
}

+(void) debug:(NSString *)message from:(NSString *)from jsonMessage:(BOOL)isJson {
    [[self instance] sendDebugMessage:message fromComponent:from isJson:isJson];
    NSLog(@"(%@) %@", from, message);
}


@end
