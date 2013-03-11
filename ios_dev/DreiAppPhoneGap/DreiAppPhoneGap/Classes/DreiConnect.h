//
//  DreiConnect.h
//  DreiAppPhoneGap
//
//  Created by Stephen Trusheim on 3/10/13.
//
//

#import "Cordova/CDV.h"

@interface DreiConnect : CDVPlugin

-(void) start:(CDVInvokedUrlCommand *)command;
-(void) stop:(CDVInvokedUrlCommand *)command;
-(void) upload:(CDVInvokedUrlCommand *)command;

-(void) sendMessage:(NSString *)message toCallback:(NSString *)callback;


@end
