//
//  DreiFakeDataService.h
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/10/13.
//

#import "DreiDataService.h"

/*
 * The fake data service creates randomized data using the same methods as the real data service.
 * The random data intervals should match up pretty exactly with actual scenarios, but the data will make
 * pretty much no physical sense (e.g. the odometer is random within 1000,10000)
 * 
 * Intended for testing on laptops to ensure that the rest of the code is stable. It's a one-line code change
 * to change from FakeDataService to RealDataService.
 */
@interface DreiFakeDataService : DreiDataService

@end
