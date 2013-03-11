//
//  DreiBMWDataSend.m
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "DreiBMWDataSendTests.h"
#import "DreiBMWFormatter.h"
#import "DreiUploader.h"
#import "DreiFakeDataService.h"


@implementation DreiTBMWDataSendTests


DreiDataService *d;

- (void) processData {
    NSLog(@"Called process data");
    NSData * jsonCarData = [DreiBMWFormatter formatCarData:[d getData] error:nil];
    DreiUploader * uploader = [[DreiUploader alloc]  init];
    [uploader postJSON:jsonCarData toURL:[NSURL URLWithString:TESTING_URL]];
    NSLog(@"Finished posting the data");
}

- (void)testSendDataToServer:(IDView *)view
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(processData) userInfo:nil repeats:false];
}

- (void) setUp
{
    d = [[DreiFakeDataService alloc] init];
    [d startCollection];
}

-(void)tearDown
{
    [d release];
}
@end
