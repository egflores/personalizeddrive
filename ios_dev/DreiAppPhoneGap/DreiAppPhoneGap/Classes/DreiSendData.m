//
//  DreiSendData.m
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import "DreiSendData.h"
#import "DreiBMWFormatter.h"
#import "DreiUploader.h"
#import "DreiFakeDataService.h"

@implementation DreiSendData

DreiDataService *d;
DreiUploader * uploader;

/**
 * TODO: Instead of using the fake data service, use the real data service!
 */
- (id) initWithCDS:(IDCdsService *)cdsService {
    if(self == [super init]) {
        d = [[DreiFakeDataService alloc] init];
        uploader = [[DreiUploader alloc]  init];
        [d startCollection];
    }
    return self;
}

- (void) sendDataToServer {
    NSLog(@"Send data to the server");
    NSData * jsonCarData = [DreiBMWFormatter formatCarData:[d getData] error:nil];
    [uploader postJSON:jsonCarData toURL:[NSURL URLWithString:@"http://requestb.in/1coa33p1"]]; //TODO: Use manifest
}

@end
