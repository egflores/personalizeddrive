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

- (id) init {
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
    [uploader postJSON:jsonCarData toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/rawcardata/update"]]; //TODO: Use manifest
}

@end
