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

@interface DreiCarCenter : NSObject

@property(retain) BMWManager * manager;
@property(retain) DreiConnect * connectEndpoint;

/* Message endpoint management */
+ (DreiCarCenter *)instance;
- (BOOL)sendMessage:(NSString *)status toCallback:(NSString *) callback;
- (BOOL)hasConnectEndpoint;
- (BOOL)hasBMWUIEndpoint;

/* Data endpoints for applications */
- (void)updateCarConnectionStatus:(BOOL)carConnected;
- (void)updateCarDataService:(IDCdsService *)newDataService;

/* Car data */
- (BOOL)hasDataService;
- (IDCdsService *)getDataService;

/* Drive log */
- (void) driveLog_uploadDataRaw;
- (void) driveLog_startCollection;
- (void) driveLog_stopCollection;
- (void) driveLog_clearData;

@end
