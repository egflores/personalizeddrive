//
//  DreiConnect.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//
#import "Cordova/CDV.h"

/**
 * Interfaces with Cordova to allow the HTML UI to do app tasks.
 *
 * See callback docs for more information about how the sendMessage functionality works.
 * essentially, always calls a Javascript function called drei_callback_[callback]([string message]).
 */
@interface DreiConnect : CDVPlugin

-(void) startDriveLog:(CDVInvokedUrlCommand *)command;
-(void) stopDriveLog:(CDVInvokedUrlCommand *)command;
-(void) uploadDriveLog:(CDVInvokedUrlCommand *)command;
-(void) clearDriveLog:(CDVInvokedUrlCommand *)command;

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback;


@end
