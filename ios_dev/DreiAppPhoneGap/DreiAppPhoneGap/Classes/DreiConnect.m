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
    [DreiCarCenter debug:@"Linked DreiConnect" from:@"DreiConnect" jsonMessage:false];
}

- (void)startDriveLog:(CDVInvokedUrlCommand*)command
{
    BOOL success = [[DreiCarCenter instance] driveLog_startCollection];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)stopDriveLog:(CDVInvokedUrlCommand*)command
{
    BOOL success = [[DreiCarCenter instance] driveLog_stopCollection];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)uploadDriveLog:(CDVInvokedUrlCommand*)command
{
    BOOL success = [[DreiCarCenter instance] driveLog_uploadDataRaw];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)clearDriveLog:(CDVInvokedUrlCommand*)command
{
    BOOL success = [[DreiCarCenter instance] driveLog_clearData];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback {
    NSString *newString = [NSString stringWithFormat:@"drei_callback_%@('%@');",callback,message];
    //NSLog(@"%@",newString);
    [self writeJavascript:newString];
}

-(void) sendDebugMessage:(NSString *)message fromComponent:(NSString *)component isJson:(BOOL)isJson {
    NSString *newString = [NSString stringWithFormat:@"drei_callback_debug(\"%@\",\"%@\",%d);",component,message,isJson];
    [self writeJavascript:newString];
    //CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    //[self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
}

@end
