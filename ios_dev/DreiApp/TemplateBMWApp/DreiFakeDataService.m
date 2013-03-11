//
//  DreiFakeDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/10/13.
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

/* Sets up all the fake data service timers... times are chosen to make it look more real
 */
-(void)setupFakeData {
    timers = [[NSMutableArray alloc] init];
    NSTimer * headlight_timer = [[NSTimer scheduledTimerWithTimeInterval:60
                                                                  target:self
                                                                selector:@selector(handleHeadlightCallback)
                                                                userInfo:nil
                                                                 repeats:true] autorelease];
    [timers addObject:headlight_timer];
    
    NSTimer * speed_timer = [[NSTimer scheduledTimerWithTimeInterval:0.75
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

// headlights from 0-1 (on/off)
- (void)handleHeadlightCallback {
    int lowerBound = 0; int upperBound = 2; // goes to upperBound-1
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"headlights"];
}

// speed from 30-100 mph
- (void)handleSpeedCallback {
    int lowerBound = 30; int upperBound = 101;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"speedActual"];
}

// odometer from 1000 to 2000 miles
- (void)handleOdometerCallback{
    int lowerBound = 1000; int upperBound = 2001;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"odometer"];
}

// engine code 0-2 (on/off/etc)
- (void)handleEngineCallback {
    int lowerBound = 0; int upperBound = 3;
    NSNumber *rand = [NSNumber numberWithInt:lowerBound + arc4random() % (upperBound - lowerBound)];
    [self._currentValues setValue:rand forKey:@"engine_status"];
}

// fuel range from 10-400 miles
// tank level from 10-100%
// reserve tank always 0 (not in use)
- (void)handleFuelCallback {
    NSNumber *rand_range = [NSNumber numberWithInt:(arc4random() % 390) + 10];
    [self._currentValues setValue:rand_range forKey:@"fuel_range"];
    
    NSNumber *rand_tanklevel = [NSNumber numberWithInt:(arc4random() % 90) + 10];
    [self._currentValues setValue:rand_tanklevel forKey:@"fuel_level"];
    [self._currentValues setValue:0 forKey:@"fuel_reserve"];
}

@end
