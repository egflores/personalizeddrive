//
//  DreiCarCenter.h
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import <Foundation/Foundation.h>
#import "BMWManager.h"
#import "DreiConnect.h"
#import "DreiCarLogger.h"

@interface DreiCarCenter : NSObject

@property(retain) BMWManager * manager;
@property(retain) DreiConnect * connectEndpoint;
@property(retain) DreiCarLogger * carLogger;

+ (DreiCarCenter *)instance;
- (DreiCarLogger *)getCarLogger;
- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback;
- (BOOL)hasDataService;
- (BOOL)hasConnectEndpoint;


@end
