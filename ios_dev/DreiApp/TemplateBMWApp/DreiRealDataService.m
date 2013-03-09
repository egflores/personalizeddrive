//
//  DreiRealDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
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

- (void)setupCDSCallbacks {
    NSLog(@"yep");

    [self initCurrentValues:[[NSArray alloc] initWithObjects:@"headlights", @"speedActual", @"odometer",nil]];
    
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
}

- (void)completionBlock:(NSError *)error {
    NSLog(@"Got cblock");
}

- (void)handleHeadlightCallback: (NSDictionary *)data {
    [self handleAsyncCallback:CDSControlsHeadlights dictKey:@"headlights" data:data];
}

- (void)handleSpeedCallback: (NSDictionary *)data {
    [self handleAsyncCallback:CDSDrivingSpeedActual dictKey:@"speedActual" data:data];
}

- (void)handleOdometerCallback: (NSDictionary *)data {
    [self handleAsyncCallback:CDSDrivingOdometer dictKey:@"odometer" data:data];
}

- (void)handleAsyncCallback:(NSString *)key dictKey:(NSString *)dictKey data:(NSDictionary *)datadict {
    NSLog(@"Got callback");
    NSLog(@"%@:%@",dictKey,[datadict valueForKey:dictKey]);
    [self._currentValues setValue:[datadict valueForKey:dictKey] forKey:dictKey];
}
@end
