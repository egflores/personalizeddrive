//
//  DreiConnect.h
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "Cordova/CDV.h"

@interface DreiConnect : CDVPlugin

-(void) startDriveLog:(CDVInvokedUrlCommand *)command;
-(void) stopDriveLog:(CDVInvokedUrlCommand *)command;
-(void) uploadDriveLog:(CDVInvokedUrlCommand *)command;
-(void) clearDriveLog:(CDVInvokedUrlCommand *)command;

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback;


@end
