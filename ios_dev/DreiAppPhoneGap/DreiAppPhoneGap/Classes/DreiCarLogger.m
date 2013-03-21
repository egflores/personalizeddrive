//
//  DreiSendData.m
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import "DreiCarLogger.h"
#import "DreiBMWFormatter.h"
#import "DreiUploader.h"
#import "DreiDebugDataService.h"

@implementation DreiCarLogger

DreiDataService *d;
DreiUploader * uploader;

/**
 * TODO: Instead of using the fake data service, use the real data service!
 */
- (id) initWithCDS:(IDCdsService *)cdsService {
    if(self == [super init]) {
        d = [[DreiDebugDataService alloc] init];
        uploader = [[DreiUploader alloc]  init];
    }
    return self;
}

- (void)updateCDS:(IDCdsService *)cdsService {
    [d updateDataService:cdsService];
}

- (void) uploadData {
    NSLog(@"Send data to the server");
    NSData * jsonCarData = [DreiBMWFormatter formatCarData:[d getData] error:nil];
    [uploader postJSON:jsonCarData toURL:[NSURL URLWithString:@"http://bmw.stanford.edu/1.0/rawcardata/update"]]; //TODO: Use manifest
}

- (void) startCollection {
    [d startCollection];
}

- (void) stopCollection {
    [d stopCollection];
}

@end
