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
#import "MainViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "Mixpanel.h"

@implementation DreiConnect

- (void) pluginInitialize {
    [DreiCarCenter instance].connectEndpoint = self;
    [DreiCarCenter debug:@"Linked DreiConnect" from:@"DreiConnect" jsonMessage:false];
}

- (void)startDriveLog:(CDVInvokedUrlCommand*)command
{
    [[Mixpanel sharedInstance] track:@"Started Drive Log"];
    BOOL success = [[DreiCarCenter instance] driveLog_startCollection];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)stopDriveLog:(CDVInvokedUrlCommand*)command
{
    
    BOOL success = [[DreiCarCenter instance] driveLog_stopCollection];
    
    NSString * statistics = [[DreiCarCenter instance] driveLog_getStatisticsJSON];
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:statistics];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    [[Mixpanel sharedInstance] track:@"Stopped Drive Log"];
}

- (void)uploadDriveLog:(CDVInvokedUrlCommand*)command
{
    //BOOL success = [[DreiCarCenter instance] driveLog_uploadDataRaw];
    [[Mixpanel sharedInstance] track:@"Upload Drive Log"];
    BOOL success = true;
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)clearDriveLog:(CDVInvokedUrlCommand*)command
{
    [[Mixpanel sharedInstance] track:@"Clear Drive Log"];
    BOOL success = [[DreiCarCenter instance] driveLog_clearData];
    
    CDVPluginResult* result = nil;
    if (success) result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    else result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)logout:(CDVInvokedUrlCommand*)command
{
    [[Mixpanel sharedInstance] track:@"Logout"];
    [PFUser logOut];
    CDVPluginResult* result = nil;
    if ([PFUser currentUser] == nil) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"{success: 1}"];
        MainViewController *mainViewController = (MainViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [mainViewController checkLoginStatus];
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback {
    return [self sendMessage:message toCallback:callback isJson:FALSE];
}

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback isJson:(BOOL)isJson {
    NSString *jsString;
    if (!isJson) {
        jsString = [NSString stringWithFormat:@"drei_callback_%@('%@');",callback,message];
    } else {
        jsString = [NSString stringWithFormat:@"drei_callback_%@(%@);",callback,message];
    }
    //NSLog(@"%@",jsString);
    [self writeJavascript:jsString];
}

-(void) sendDebugMessage:(NSString *)message fromComponent:(NSString *)component isJson:(BOOL)isJson {
    NSString *newString = [NSString stringWithFormat:@"drei_callback_debug(\"%@\",\"%@\",%d);",component,message,isJson];
    [self writeJavascript:newString];
    //CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    //[self.commandDelegate sendPluginResult:pluginResult callbackId:callback];
}

// dummy to ensure that DreiConnect links as soon as possible
- (void)init:(CDVInvokedUrlCommand*)command
{
    NSLog(@"Init Called *********************************************");
    CDVPluginResult*  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getDriveLogs:(CDVInvokedUrlCommand*)command
{
    [[Mixpanel sharedInstance] track:@"Requested Drive Logs"];
    PFQuery *query = [PFQuery queryWithClassName:@"DL_Entry"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"total_time" greaterThan:[NSNumber numberWithInt:0]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray * dictObjects = [[NSMutableArray alloc] initWithCapacity:[objects count]];
            for (int i = 0; i < [objects count]; ++i) {
                [dictObjects insertObject:[[objects objectAtIndex:i] toDict:true] atIndex:i];
            }
            NSString *json = [[NSString alloc] initWithData:
                              [NSJSONSerialization dataWithJSONObject:dictObjects
                                                              options:0
                                                                error:nil]
                                                   encoding:NSUTF8StringEncoding
                              ];
            
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:json];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            // The find succeeded.
        } else {
            NSLog(@"Error getting objects: %@ %@", error, [error userInfo]);
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)sendFeedback:(CDVInvokedUrlCommand *)command
{
    [[Mixpanel sharedInstance] track:@"Sent Feedback"];
    CDVPluginResult* pluginResult = nil;
    NSString* feedback = [command.arguments objectAtIndex:0];
    if (feedback != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        PFObject *gameScore = [PFObject objectWithClassName:@"Feedback"];
        [gameScore setObject:feedback forKey:@"feedback"];
        [gameScore saveInBackground];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
