//
//  DreiSmartSend.m
//  DreiAppPhoneGap
//
//  Created by Rowan Chakoumakos on 4/16/13.
//
//


#import "DreiSmartSend.h"


@implementation DreiSmartSend

NSTimer * uploadTimer;
NSTimeInterval timeBeforeNextAttempt;
bool hasStarted = false;

-(void)start {
    NSLog(@"SMART SEND");
    if(hasStarted) return;
    timeBeforeNextAttempt = 10;
    uploadTimer = [NSTimer scheduledTimerWithTimeInterval:timeBeforeNextAttempt target:self selector:@selector(tryUpload) userInfo:nil repeats:YES];
}

-(void)tryUpload {

    
}

-(void)stop {
    if(!hasStarted) return;
    
}

@end
