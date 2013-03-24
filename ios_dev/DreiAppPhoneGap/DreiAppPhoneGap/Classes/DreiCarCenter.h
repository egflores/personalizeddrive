//
//  DreiCarCenter.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import <Foundation/Foundation.h>
#import "DreiBMWManager.h"
#import "DreiConnect.h"

/**
 * DreiCarCenter is a singleton that allows multiple UI models to accomplish the same underlying tasks without
 * stomping on one another. 
 *
 * Currently implemented is DriveLog (logs car physical data every so often to create a drive log).
 */

@interface DreiCarCenter : NSObject

@property(retain) DreiBMWManager * manager;
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
- (void) driveLog_uploadCommuteLog;
- (void) driveLog_startCollection;
- (void) driveLog_stopCollection;
- (void) driveLog_clearData;

/* Debug */
+ (void) debug:(NSString *)message from:(NSString *)from jsonMessage:(BOOL)isJson;

@end
