//
//  DreiConnect.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//
#import "Cordova/CDV.h"

@interface DreiConnect : CDVPlugin

-(void) startDriveLog:(CDVInvokedUrlCommand *)command;
-(void) stopDriveLog:(CDVInvokedUrlCommand *)command;
-(void) uploadDriveLog:(CDVInvokedUrlCommand *)command;
-(void) clearDriveLog:(CDVInvokedUrlCommand *)command;

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback;


@end
