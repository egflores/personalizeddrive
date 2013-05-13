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

@synthesize _lastPoint;
@synthesize _currentPoint;

- (id)init {
    if (self = [super init]) {
        self.interval = 0.25; // default interval is 1/4 second
    }
    return self;
}

-(void) dealloc {
    [self stopCollection];
}

-(void)startCollection {
    if (self.in_collection) {
        [self stopCollection];
    }
    self.in_collection = TRUE;
    
    self._lastPoint = [[DL_DataPoint alloc] init];
    self._currentPoint = [[DL_DataPoint alloc] init];
    self._entry = [[DL_Entry alloc] init];
    self._entry.startTime = [NSDate dateWithTimeIntervalSinceNow:0];
    self._saveCache = [[NSMutableArray alloc] init];
    
    self._currentPoint.entry = self._entry;
    self._lastPoint.entry = self._entry;
    
    self._synchTimer = [NSTimer scheduledTimerWithTimeInterval:self.interval
                                                   target:self
                                                 selector:@selector(saveDataCallback)
                                                 userInfo:nil
                                                  repeats:true];
    [[DreiCarCenter instance] updateDriveLogStatus:true];

}

-(void)stopCollection {
    if (!self.in_collection) return;
    
    if (self._entry) {
        [self._entry setUser:[PFUser currentUser]];
        [self._entry calcStatistics:self._saveCache];
        [self._entry saveEventually];
        self._saveCache = nil;
    }
    [self._synchTimer invalidate];
    self._synchTimer = nil;
    self.in_collection = false;
    [[DreiCarCenter instance] updateDriveLogStatus:false];
}

-(void)saveDataCallback {
    if ([self._currentPoint equals:self._lastPoint]) return; // don't save point if identical to last point
    
    [self._currentPoint setTimestampNow];
    [self._currentPoint processCalcValues];
    //[self._currentPoint saveEventually];
    [self._saveCache addObject:self._currentPoint]; // save in the cache for now
    self._lastPoint = self._currentPoint;
    self._currentPoint = [[DL_DataPoint alloc] initFromPoint:self._lastPoint];
 
    NSLog(@"Passing shit up");
    [[DreiCarCenter instance] driveLog_updateData:[self._lastPoint toDict]];
}

-(DL_Entry *)getEntry {
    if (self.in_collection) return nil;
    return self._entry;
}


@end
