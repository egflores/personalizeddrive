//
//  DreiCarCenter.m
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "DreiCarCenter.h"
#import "DreiCarLogger.h"

@implementation DreiCarCenter

# pragma mark Singleton constructor

static DreiCarCenter *gInstance = NULL;

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

/* Only in here because we needed a singleton to handle grabbing the logger */
-(DreiCarLogger *)getCarLogger {
    if (self.carLogger == nil) {
        if ([self hasDataService]) {
            self.carLogger= [[[DreiCarLogger alloc] initWithCDS:[self getDataService]] autorelease];
        }
        else {
            NSLog(@"Cannot setup data service - no CDS");
        }
    }
    return self.carLogger;
    
}

-(BOOL)hasConnectEndpoint {
    return (self.connectEndpoint != nil);
}

- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback {
    if (self.connectEndpoint == NULL) return false;
    [self.connectEndpoint sendMessage:status toCallback:callback];
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
    [[self getCarLogger] updateCDS:newDataService];
    if (newDataService != nil) {
        [self sendMessage:@"hasDataService" toCallback:@"connection"];
    } else {
        [self sendMessage:@"noDataService" toCallback:@"connection"];
    }
}

-(void)updateCarLogging:(BOOL)logging {
    if (logging) {
        [self sendMessage:@"logOff" toCallback:@"carlogging"];
    } else {
        [self sendMessage:@"logOn" toCallback:@"carlogging"];

    }
}

@end
