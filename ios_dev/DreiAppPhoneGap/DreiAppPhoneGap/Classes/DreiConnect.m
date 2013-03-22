//
//  DreiConnect.m
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import "DreiConnect.h"
#import "DreiCarCenter.h"
#import "Cordova/CDV.h"

@implementation DreiConnect

- (void) pluginInitialize {
    [DreiCarCenter instance].connectEndpoint = self;
}

- (void)startDriveLog:(CDVInvokedUrlCommand*)command
{
    [[DreiCarCenter instance] driveLog_startCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopDriveLog:(CDVInvokedUrlCommand*)command
{
    [[DreiCarCenter instance] driveLog_stopCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)uploadDriveLog:(CDVInvokedUrlCommand*)command
{
    [[DreiCarCenter instance] driveLog_uploadDataRaw];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)clearDriveLog:(CDVInvokedUrlCommand*)command
{
    [[DreiCarCenter instance] driveLog_clearData];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/*
 * TODO: Rowan, Javascript master, needs to look at this.
 */
-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback {
    NSString *newString = [NSString stringWithFormat:@"drei_callback_%@(%@);",callback,message];
    [self writeJavascript:newString];
    //CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    //[self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
}

@end
