//
//  DreiSmartSend.m
//  DreiAppPhoneGap
//
//  Created by Rowan Chakoumakos on 4/16/13.
//
//


#import "DreiSmartSend.h"
#import "Reachability.h"

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
    NetworkStatus currentStatus = [[Reachability reachabilityForInternetConnection]
                                   currentReachabilityStatus];
    
    if(currentStatus == ReachableViaWWAN) { // 3G
        NSLog(@"3G");
    } else if(currentStatus == ReachableViaWiFi) { //wifi
        NSLog(@"Wifi");
    } else if(currentStatus == NotReachable) { // no connection currently possible
        NSLog(@"No connection");
    }
    
}

-(void)stop {
    if(!hasStarted) return;
    
}

@end
