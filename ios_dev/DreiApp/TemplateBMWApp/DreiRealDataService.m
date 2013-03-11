//
//  DreiRealDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//

#import "DreiRealDataService.h"
#import <BMWAppKit/BMWAppKit.h>

@implementation DreiRealDataService

- (id)initWithCDS:(IDCdsService *) cdsService {
    if (self == [super init]) {
        self._cdsService = cdsService;
        
        [self setupCDSCallbacks];
        
    }
    return self;
}

/* Sets up all the CDS async callbacks.
 * TODO: more CDS data?
 */
- (void)setupCDSCallbacks {
    [self._cdsService asyncGetProperty:CDSControlsHeadlights
                                target:self
                              selector:@selector(handleHeadlightCallback:)
                       completionBlock:^(NSError *error) { [self completionBlock:error]; }
     ];
    [self._cdsService asyncGetProperty:CDSDrivingSpeedActual
                                target:self
                              selector:@selector(handleSpeedCallback:)
                       completionBlock:^(NSError *error) { [self completionBlock:error]; }
     ];
    [self._cdsService asyncGetProperty:CDSDrivingOdometer
                                target:self
                              selector:@selector(handleOdometerCallback:)
                       completionBlock:^(NSError *error) { [self completionBlock:error]; }
     ];
    [self._cdsService asyncGetProperty:CDSEngineStatus
                                target:self
                              selector:@selector(handleEngineCallback:)
                       completionBlock:^(NSError *error) { [self completionBlock:error]; }
     ];
    [self._cdsService asyncGetProperty:CDSSensorsFuel
                                target:self
                              selector:@selector(handleFuelCallback:)
                       completionBlock:^(NSError *error) { [self completionBlock:error]; }
     ];
}

// TODO: what kinds of important messages might I get here?
- (void)completionBlock:(NSError *)error {
    NSLog(@"Got completion block! Zippiedee doo dah!");
}

/* ----
 * Below here are the various callbacks from the CDS. These functions all grab the appropriate values from the
 * CDS dictionary and put them into the cached value dict.
 */

- (void)handleHeadlightCallback: (NSDictionary *)data {
    [self._currentValues setValue:[data valueForKey:@"headlights"] forKey:@"headlights"];
}

- (void)handleSpeedCallback: (NSDictionary *)data {
    [self._currentValues setValue:[data valueForKey:@"speedActual"] forKey:@"speedActual"];
}

- (void)handleOdometerCallback: (NSDictionary *)data {
    [self._currentValues setValue:[data valueForKey:@"odometer"] forKey:@"odometer"];
}

- (void)handleEngineCallback: (NSDictionary *)data {
    [self._currentValues setValue:[data valueForKey:@"status"] forKey:@"engine_status"];
}

// TODO: I never get this callback, so I'm not sure that this function will actually work.
// wrote it according to BMW's API docs, though.
- (void)handleFuelCallback: (NSDictionary *)data {
    [self._currentValues setValue:[[data valueForKey:@"fuel"] valueForKey:@"range"] forKey:@"fuel_range"];
    [self._currentValues setValue:[[data valueForKey:@"fuel"] valueForKey:@"tanklevel"] forKey:@"fuel_level"];
    [self._currentValues setValue:[[data valueForKey:@"fuel"] valueForKey:@"reserve"] forKey:@"fuel_reserve"];
}

@end
