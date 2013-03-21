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

/* Standard/low-level methods for working with the CarCenter */
+ (DreiCarCenter *)instance;
- (DreiCarLogger *)getCarLogger;
- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback;
- (BOOL)hasDataService;
- (IDCdsService *)getDataService;
- (BOOL)hasConnectEndpoint;

/* Message endpoints for applications */
- (void)updateCarConnectionStatus:(BOOL)carConnected;
- (void)updateCarDataService:(IDCdsService *)newDataService;

/* CarLogger endpoints to centralize UI requests */
- (void)updateCarLogging:(BOOL)logging;



@end
