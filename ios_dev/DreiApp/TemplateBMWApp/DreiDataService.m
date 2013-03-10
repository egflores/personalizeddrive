//
//  DreiDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import "DreiDataService.h"

@implementation DreiDataService

- (id)init {
    if (self = [super init]) {
        self._dataStore = [[NSMutableArray alloc] initWithCapacity:100];
        self._currentValues = [[[NSMutableDictionary alloc] initWithCapacity:10] retain];
        NSLog(@"done and done!");
        [self startTimer];
    }
    return self;
}

-(void)initCurrentValues:(NSArray *)keys {
    for (NSString * obj in keys) {
        [self._currentValues setValue:@"NODATA" forKey:obj];
    }
}

-(void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(saveDataCallback)
                                   userInfo:nil
                                    repeats:true];
}

-(void)saveDataCallback {
    NSMutableDictionary * dictCopy = [self._currentValues mutableCopy];
    [dictCopy setValue:[[NSNumber alloc] initWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"time"];
    NSDictionary *newDict = [dictCopy copy];
    [dictCopy release];
    
    [self._dataStore addObject:newDict];
    NSLog(@"%@",self._dataStore);
}

@end
