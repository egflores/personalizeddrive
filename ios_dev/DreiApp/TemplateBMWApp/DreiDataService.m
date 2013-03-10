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
        [self initCurrentValues:[self getDataKeys]];
    }
    return self;
}

-(NSArray *)getDataKeys {
    return [[NSArray alloc]
            initWithObjects:@"headlights", @"speedActual", @"odometer",@"engine_status",@"fuel_range",@"fuel_level",@"fuel_reserve",nil
            ];
}

-(void)initCurrentValues:(NSArray *)keys {
    for (NSString * obj in keys) {
        [self._currentValues setValue:@"NODATA" forKey:obj];
    }
}

-(void)startCollection {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(saveDataCallback)
                                   userInfo:nil
                                    repeats:true];
}

-(void)stopCollection {
    [self.timer invalidate];
}

-(NSArray *)getData {
    return self._dataStore;
}

-(void)saveDataCallback {
    NSMutableDictionary * dictCopy = [self._currentValues mutableCopy];
    [dictCopy setValue:[[NSNumber alloc] initWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"time"];
    NSDictionary *newDict = [dictCopy copy];
    [dictCopy release];
    
    [self._dataStore addObject:newDict];
}

@end
