//
//  DL_DataPoint.m
//  DreiOBD2
//
//  Created by Stephen Trusheim on 5/10/13.
//
//

#import "DL_DataPoint.h"

@implementation DL_DataPoint

@dynamic entry;
@dynamic kph;
@dynamic mpg;
@dynamic gps_lat;
@dynamic gps_long;
@dynamic rpm;
@dynamic maf;
@dynamic timestamp;

-(id) init {
    self = [super init];
    [self setInvalid];
    return self;
}

-(id)initFromPoint:(DL_DataPoint *)point {
    self = [self init];
    self.entry = point.entry;
    self.kph = point.kph;
    self.mpg = point.mpg;
    self.gps_lat = point.gps_lat;
    self.gps_long = point.gps_long;
    self.rpm = point.rpm;
    self.maf = point.maf;
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:[point.timestamp timeIntervalSince1970]];
    return self;
}

- (NSDictionary *) toDict {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithDouble:self.gps_lat], @"gps_latitude",
            [NSNumber numberWithDouble:self.gps_long], @"gps_longitude",
            [NSNumber numberWithDouble:self.kph], @"vehicle_speed",
            [NSNumber numberWithDouble:self.rpm], @"rpm",
            [NSNumber numberWithDouble:self.mpg], @"instant_mpg",
            [NSNumber numberWithDouble:[self.timestamp timeIntervalSince1970]], @"timestamp",
            nil];
}
+ (NSString *)parseClassName {
        return @"DL_DataPoint";
}

-(void)setInvalid {
    self.kph = -1;
    self.mpg = -1;
    self.gps_lat = 0;
    self.gps_long = 0;
    self.rpm = -1;
    self.maf = -1;
    self.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
}

-(void)setTimestampNow {
    self.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
}

-(BOOL)equals:(DL_DataPoint *)other {
    if (self.entry != other.entry) return false;
    if (self.kph != other.kph) return false;
    if (self.mpg != other.mpg) return false;
    if (self.gps_lat != other.gps_lat) return false;
    if (self.gps_long != other.gps_long) return false;
    if (self.maf != other.maf) return false;
    if (self.rpm != other.rpm) return false;
    
    return true;
}

- (void)processCalcValues {
    // calculate instant MPG
    double instantMpg = [DL_DataPoint calcInstantMPG:self.kph airFlow:self.maf];
    //NSLog(@"MPG: %f", [mpg doubleValue]);
    self.mpg = instantMpg;
}

/* Adopted straight from FLECU code... no idea how it works or what these magic constants are */
+(double) calcInstantMPG:(double) kph airFlow:(double) maf {
    
	if(kph > 255) {
		kph = 255;
	}
    
	if(kph < 0) {
		kph = 0;
	}
    
    
	if(maf <= 0) {
		maf = 0.1;
	}
	
	return ((14.7 * 6.17 * 454.0 * kph * 0.621371) / (3600.0 * maf));
}
@end
