//
//  DreiSyncDataProvider.h
//  BasicScan
//
//  Created by Stephen Trusheim on 4/29/13.
//
//

#import <Foundation/Foundation.h>
#import "DL_DataPoint.h"
#import "DL_Entry.h"

/* The DreiSynchDataProvider takes the asynchronous CDS API and makes it deliver consistent, predictable data at regular, time-stamped intervals. The main benefit / reason for this framework is two-fold: 1. make us able to have constant data logging over the API, and 2. to allow us to make fake data when we're simulating.
 *
 * The data service sits on top of the async calls and manages that interaction entirely. Just call startCollection, stopCollection, and getData when necessary.
 *
 * Calling getData will return an NSArray of NSDictionaries. Each dictionary represents a single time slice, and has all the keys defined in getDataKeys, and one more: "time". The data returned is all in the format it was in when it came off the BMW API. The data in each dictionary is the most recent data when that entry was logged. The data will come in at approximately the logging interval.
 *
 * If no data is available for a given piece of information (e.g. the speed never came in), the dictionary value for that item will be the String "NODATA".
 *
 * This class should not be instantiated directly. Use DreiSynchDataProvider_BMW (for when you're in production in a car) or DreiSynchDataProvider_Random (for on your laptop - the BMW simulator doesn't really let you make up fake data).
 *
 * TODOS: allow user to specify the logging interval, get data as it's streaming in (delegate function). Check memory management.
 */


@interface DreiSynchDataProvider : NSObject

@property (atomic, retain) NSMutableArray * _saveCache;
@property DL_DataPoint * _currentPoint;
@property DL_DataPoint * _lastPoint;
@property DL_Entry * _entry;
@property (atomic,retain) NSTimer * _synchTimer;
@property (atomic) float interval;
@property BOOL in_collection;


/* Starts data collection (logs to _dataStore) */
-(void)startCollection;

/* Stops data collection */
-(void)stopCollection;

-(DL_Entry *)getEntry;

@end