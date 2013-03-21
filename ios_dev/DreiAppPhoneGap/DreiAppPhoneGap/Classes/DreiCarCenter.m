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

# pragma mark Instance methods

NSString *subscribeCallback;

-(id)init {
    self = [super init];
    return self;
}

-(BOOL)haveCDS {
    if (self.manager && self.manager.application && self.manager.application.cdsService) return true;
    return false;
}

-(DreiCarLogger *)getCarLogger {
    if (self.carLogger == nil) {
        if ([self haveCDS]) {
            self.carLogger= [[[DreiCarLogger alloc] initWithCDS:self.manager.application.cdsService] autorelease];
        }
        else {
            NSLog(@"Cannot setup data service - no CDS");
        }
    }
    return self.carLogger;
    
}

- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback {
    if (self.connectEndpoint == NULL) return false;
    [self.connectEndpoint sendMessage:status toCallback:callback];
    return true;
}

@end
