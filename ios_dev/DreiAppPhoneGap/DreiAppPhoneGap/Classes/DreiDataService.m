//
//  DreiDataService.m
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//

#import "DreiDataService.h"
#import "DreiPGNotification.h"
#import "DreiBMWFormatter.h"

@implementation DreiDataService

- (id)init {
    if (self = [super init]) {
        self._dataStore = [[NSMutableArray alloc] initWithCapacity:100];
        self._currentValues = [[[NSMutableDictionary alloc] initWithCapacity:10] retain];
        [self initCurrentValues:[self getDataKeys]];
        self.on = false;
    }
    return self;
}

/*
 * TODO: abstract this out somehow?
 */
-(NSArray *)getDataKeys {
    return [[NSArray alloc]
            initWithObjects:@"headlights", @"speedActual", @"odometer",@"engine_status",@"fuel_range",@"fuel_level",@"fuel_reserve",nil
            ];
}

/* "NODATA" is the sentinel for when no async callback has come in yet. */
-(void)initCurrentValues:(NSArray *)keys {
    for (NSString * obj in keys) {
        [self._currentValues setValue:@"NODATA" forKey:obj];
    }
}

-(void)startCollection {
    self._timer = [[NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(saveDataCallback)
                                   userInfo:nil
                                    repeats:true] retain];
    self.on = true; // HACK
}

-(void)stopCollection {
    [self._timer invalidate];
    [self._timer release];
    self._timer = nil;
    self.on = false; // HACK
    NSLog(@"Stopped collection");
}

-(NSArray *)getData {
    return self._dataStore;
}

-(void)saveDataCallback {
    //if (!self.on) return; // HACK
    NSMutableDictionary * dictCopy = [self._currentValues mutableCopy];
    [dictCopy setValue:[[NSNumber alloc] initWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"time"];
    NSDictionary *newDict = [dictCopy copy];
    [dictCopy release];
    
    [self._dataStore addObject:newDict];
    [[DreiPGNotification instance] sendMessage:[DreiBMWFormatter formatDataEntryToString:newDict error:nil] toCallback:@"dataEntry"];
    //NSLog(@"%@",newDict);
}

@end
