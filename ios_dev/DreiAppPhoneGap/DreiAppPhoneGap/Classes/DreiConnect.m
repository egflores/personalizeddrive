//
//  DreiConnect.m
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "DreiConnect.h"
#import "DreiPGNotification.h"
#import "Cordova/CDV.h"

@implementation DreiConnect

- (void) pluginInitialize {
    [DreiPGNotification instance].connectEndpoint = self;
}

- (void)start:(CDVInvokedUrlCommand*)command
{
    [[[DreiPGNotification instance] getDataService] startCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/**
 * TODO: Stop doesn't actually stop... this is an underlying problem in DreiDataService that I can't figure out.
 */
- (void)stop:(CDVInvokedUrlCommand*)command
{
    [[[DreiPGNotification instance] getDataService] stopCollection];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/**
 * TODO: subscribe seems to not work because Cordova closes the callbackId after a small window of time :(
 * How can we do multiple callbacks to the same JS?
 */
- (void)subscribe:(CDVInvokedUrlCommand*)command
{
    [[DreiPGNotification instance] setSubscribeCallback:command.callbackId];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)upload:(CDVInvokedUrlCommand*)command
{
    [[[DreiPGNotification instance] getDataService] uploadData];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
}

@end
