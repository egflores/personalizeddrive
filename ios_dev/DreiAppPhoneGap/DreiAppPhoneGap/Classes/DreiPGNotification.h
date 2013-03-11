//
//  DreiPGNotification.h
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import <Foundation/Foundation.h>
#import "BMWManager.h"

@interface DreiPGNotification : NSObject

@property BMWManager * manager;

+ (DreiPGNotification *)instance;
- (BOOL)sendStatusUpdate:(NSString *)status;

@end
