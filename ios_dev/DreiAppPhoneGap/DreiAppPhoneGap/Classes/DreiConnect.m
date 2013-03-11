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

- (void)upload:(CDVInvokedUrlCommand*)command
{
    [[[DreiPGNotification instance] getDataService] uploadData];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/*
 * TODO: Rowan, Javascript master, needs to look at this.
 */
-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback {
    NSString *newString = [NSString stringWithFormat:@"drei_callback_%@(\"%@\")",callback,message];
    [self writeJavascript:newString];
    NSLog(newString);
    //CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    //[self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
}

@end
