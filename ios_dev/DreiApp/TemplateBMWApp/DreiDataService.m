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
        [self._dataStore initWithCapacity:100];
        self._currentValues = [[[NSMutableDictionary alloc] initWithCapacity:10] retain];
        NSLog(@"done and done!");
        [self setupTimer];
    }
    return self;
}

-(void)initCurrentValues:(NSArray *)keys {
    for (NSString * obj in keys) {
        [self._currentValues setValue:@"" forKey:obj];
    }
}

-(void)setupTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(lol)
                                   userInfo:nil
                                    repeats:true];
}

-(void)lol {
    // pull the cachedvalues dict into the datastore array
    //TODO: double check memory management
    NSLog(@"I got called!");
}

@end
