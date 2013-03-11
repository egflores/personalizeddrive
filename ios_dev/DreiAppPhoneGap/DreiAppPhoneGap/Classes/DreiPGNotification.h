//
//  DreiPGNotification.h
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import <Foundation/Foundation.h>
#import "BMWManager.h"
#import "DreiConnect.h"
#import "DreiSendData.h"

@interface DreiPGNotification : NSObject

@property BMWManager * manager;
@property DreiConnect * connectEndpoint;
@property (retain) DreiSendData * dataService;

+ (DreiPGNotification *)instance;
- (DreiSendData *)getDataService;
- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback;

@end
