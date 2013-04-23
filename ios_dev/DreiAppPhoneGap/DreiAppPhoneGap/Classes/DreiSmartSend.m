//
//  DreiSmartSend.m
//  DreiAppPhoneGap
//
//  Created by Rowan Chakoumakos on 4/16/13.
//
//


#import "DreiSmartSend.h"
#import "Reachability.h"

#define INTERVAL_INITIAL 1          //1 minute
#define INTERVAL_AFTER_UPLOAD 1200 //20 minutes

@implementation DreiSmartSend

NSTimer * uploadTimer;
bool hasStarted = false;

-(void)start {
    if(hasStarted) return;
    uploadTimer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_INITIAL target:self selector:@selector(tryUpload) userInfo:nil repeats:YES];
}

-(void)tryUpload {
    NetworkStatus currentStatus = [[Reachability reachabilityForInternetConnection]
                                   currentReachabilityStatus];
    
    bool shouldUpload = false;
    if(currentStatus == ReachableViaWWAN) { // 3G
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL uploadOn3g = [defaults boolForKey:@"uploadOn3g"];
        shouldUpload = uploadOn3g;
        if(uploadOn3g) {
            NSLog(@"3G - should upload");
        } else {
            NSLog(@"3G - don't upload");
        }
        
    } else if(currentStatus == ReachableViaWiFi) { //wifi
        shouldUpload = true;
        NSLog(@"wifi - should upload");
    } else if(currentStatus == NotReachable) { // no connection currently possible
        NSLog(@"No connection");
    }
    if(shouldUpload) {
        NSLog(@"Should upload the data");
        //if upload success
        //Set the timer interval to now be 20 minutes
        // @rowanc - does this code work? No actual uploading?
        [uploadTimer invalidate];
        uploadTimer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_AFTER_UPLOAD target:self selector:@selector(tryUpload) userInfo:nil repeats:YES];
        
    }
}

-(void)stop {
    if(!hasStarted) return;
    [uploadTimer invalidate];
}

@end
