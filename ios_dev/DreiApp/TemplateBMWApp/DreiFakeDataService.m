//
//  DreiFakeDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import "DreiFakeDataService.h"

@implementation DreiFakeDataService

NSMutableArray * timers;

-(id) init {
    if (self == [super init]) {
        [self setupFakeData];
    }
    return self;
}

-(void)setupFakeData {
    timers = [[NSMutableArray alloc] init];
    NSTimer * headlight_timer = [[NSTimer scheduledTimerWithTimeInterval:60
                                                                  target:self
                                                                selector:@selector(handleHeadlightCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:headlight_timer];
    
    NSTimer * speed_timer = [[NSTimer scheduledTimerWithTimeInterval:2.25
                                                                  target:self
                                                                selector:@selector(handleSpeedCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:speed_timer];
    
    NSTimer * odometer_timer = [[NSTimer scheduledTimerWithTimeInterval:10
                                                                  target:self
                                                                selector:@selector(handleOdometerCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:odometer_timer];
    
    NSTimer * engine_timer = [[NSTimer scheduledTimerWithTimeInterval:120
                                                                  target:self
                                                                selector:@selector(handleEngineCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:engine_timer];
    
    NSTimer * fuel_timer = [[NSTimer scheduledTimerWithTimeInterval:5.0
                                                                  target:self
                                                                selector:@selector(handleFuelCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:fuel_timer];
    
    // call all the timers now
    for (NSTimer * timer in timers) {
        [timer fire];
    }
    
}

- (void)handleHeadlightCallback {
    int lowerBound = 0; int upperBound = 2; // goes to upperBound-1
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"headlights"];
}

- (void)handleSpeedCallback {
    int lowerBound = 30; int upperBound = 101;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"speedActual"];
}

- (void)handleOdometerCallback{
    int lowerBound = 1000; int upperBound = 2001;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"odometer"];
}

- (void)handleEngineCallback {
    int lowerBound = 0; int upperBound = 3;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"engine_status"];
}

- (void)handleFuelCallback {
    NSNumber *rand_range = [NSNumber numberWithInt:(arc4random() % 390) + 10];
    [self._currentValues setValue:rand_range forKey:@"fuel_range"];
    
    NSNumber *rand_tanklevel = [NSNumber numberWithInt:(arc4random() % 90) + 10];
    [self._currentValues setValue:rand_tanklevel forKey:@"fuel_level"];
    [self._currentValues setValue:0 forKey:@"fuel_reserve"];
}

@end
