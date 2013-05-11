//
//  DL_DataPoint.h
//  DreiOBD2
//
//  Created by Stephen Trusheim on 5/10/13.
//
//

#import <Parse/PFObject+Subclass.h>
#import "DL_Entry.h"

@interface DL_DataPoint : PFObject<PFSubclassing>

@property float kph;
@property float mpg;
@property float rpm;
@property float maf;
@property double gps_lat;
@property double gps_long;
@property NSDate *timestamp;

@property DL_Entry *entry;

-(id) init;
-(id)initFromPoint:(DL_DataPoint *) point;

-(NSDictionary *) toDict;
-(void)setInvalid;
-(void)setTimestampNow;
-(void)processCalcValues;

-(BOOL)equals:(DL_DataPoint *)other;

+ (NSString *)parseClassName;

@end
