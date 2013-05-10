//
//  DreiDataProvider.m
//  DreiDataService
//
//  Created by Stephen Trusheim on 4/14/13.
//  Copyright (c) 2013 BMW Drei. All rights reserved.
//

#import "DreiSynchDataProvider.h"
#import "DreiCarCenter.h"

@implementation DreiSynchDataProvider

- (id)init {
    if (self = [super init]) {
        self._dataStore = [[NSMutableArray alloc] init];
        self._currentValues = [[NSMutableDictionary alloc] initWithCapacity:10];
        [self initData:[self getDataKeys]];
        self.interval = 0.25; // default interval is 1/4 second
    }
    return self;
}

/*
 * TODO: abstract this out somehow?
 */
-(NSArray *)getDataKeys {
    return [[NSArray alloc] initWithObjects:
            @"engine_fuel_rate",
            @"fuel_level",
            @"vehicle_speed",
            @"rpm",
            @"instant_mpg",
            @"gps_latitude",
            @"gps_longitude",
            @"relative_distance",
            @"timestamp",
            nil];
}

-(void)initData:(NSArray *)keys {
    for (NSString * obj in keys) {
        // "NODATA" is the sentinel for when no async callback has come in yet.
        [self._currentValues setValue:@"NODATA" forKey:obj];
    }
}

-(void)startCollection {
    self._synchTimer = [NSTimer scheduledTimerWithTimeInterval:self.interval
                                                   target:self
                                                 selector:@selector(saveDataCallback)
                                                 userInfo:nil
                                                  repeats:true];
}

-(void)stopCollection {
    [self._synchTimer invalidate];
    self._synchTimer = nil;
}

-(NSDictionary *)getStatistics {
    NSNumber *distance = [NSNumber numberWithFloat:10.0];
    NSNumber *mpg = [NSNumber numberWithFloat:32.0];
    NSNumber *time = [NSNumber numberWithFloat:15.0];

    NSDictionary *response = [NSDictionary dictionaryWithObjectsAndKeys: distance, @"distance", mpg, @"mpg", time, @"time", nil];
    return response;
}

-(NSArray *)getAllData {
    return self._dataStore;
}

-(void)clearAllData {
    self._dataStore = [[NSMutableArray alloc] initWithCapacity:100];
}

-(NSDictionary *)getLatestData {
    return [self processDataPoint:[self._currentValues mutableCopy]];
}

-(void)saveDataCallback {
    NSMutableDictionary * dictCopy = [self processDataPoint:[self._currentValues mutableCopy]];
    [dictCopy setValue:[[NSNumber alloc] initWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    NSDictionary *newDict = [dictCopy copy];
    
    [self._dataStore addObject:newDict];
    [[DreiCarCenter instance] driveLog_updateData:newDict];
}



@end
