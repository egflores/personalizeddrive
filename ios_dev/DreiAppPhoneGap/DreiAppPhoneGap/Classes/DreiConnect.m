//
//  DreiConnect.m
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
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
    [[[DreiCarCenter instance] getCarLogger] startCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopDriveLog:(CDVInvokedUrlCommand*)command
{
    [[[DreiCarCenter instance] getCarLogger] stopCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)uploadDriveLog:(CDVInvokedUrlCommand*)command
{
    [[[DreiCarCenter instance] getCarLogger] uploadData];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)clearDriveLog:(CDVInvokedUrlCommand*)command
{
    [[[DreiCarCenter instance] getCarLogger] clearData];
    
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
