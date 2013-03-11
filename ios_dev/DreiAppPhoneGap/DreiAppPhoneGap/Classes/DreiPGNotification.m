//
//  DreiPGNotification.m
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "DreiPGNotification.h"
#import "DreiSendData.h"

@implementation DreiPGNotification

static DreiPGNotification *gInstance = NULL;

+ (DreiPGNotification *)instance {
    @synchronized(self)
    {
        if (gInstance == NULL) {
            gInstance = [[self alloc] init];
        }
    }
    
    return gInstance;
}

NSString *subscribeCallback;

-(BOOL)haveCDS {
    if (self.manager && self.manager.application && self.manager.application.cdsService) return true;
    return false;
}

-(DreiSendData *)getDataService {
    if (self.dataService == nil) {
        if ([self haveCDS]) {
            self.dataService = [[[DreiSendData alloc] initWithCDS:self.manager.application.cdsService] autorelease];
        }
        else {
            NSLog(@"Cannot setup data service - no CDS");
        }
    }
    return self.dataService;
    
}

- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback {
    if (self.connectEndpoint == NULL) return false;
    [self.connectEndpoint sendMessage:status toCallback:callback];
    return true;
}

@end
