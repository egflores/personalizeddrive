//
//  DreiPGNotification.m
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "DreiPGNotification.h"

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

-(BOOL)haveCDS {
    if (self.manager && self.manager.application && self.manager.application.cdsService) return true;
    return false;
}

- (BOOL)sendStatusUpdate:(NSString *)status {
    return true;
}

@end
