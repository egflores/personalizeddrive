//
//  DL_Entry.m
//  DreiOBD2
//
//  Created by Stephen Trusheim on 5/10/13.
//
//

#import "DL_Entry.h"
#import "DL_DataPoint.h"

@implementation DL_Entry

@dynamic user;
@dynamic startTime;

// properties that we'll fill in
@dynamic average_mpg;
@dynamic total_distance;
@dynamic total_time;
@dynamic max_speed;
@dynamic average_speed;
@dynamic num_points;


-(id)init {
    self = [super init];
    //self.user = [PFUser currentUser];
    return self;
}

-(void)calcStatistics:(NSArray *)dataPoints {
    double running_avg_mpg = 0;
    double running_total_distance = 0;
    double curr_max_speed = 0;
    double running_avg_speed = 0;
    double num_points = 0;
    
    if (!dataPoints || [dataPoints count] == 0) {
        return;
    }

    int count = [dataPoint count];

    double est_gallons_used = 0.0;
    double est_miles_traveled = 0.0;
    double curr_max_speed = 0.0;
    for (int i=0; i < num_data_points-1; ++i) {
	   DL_DataPoint obj1 = [dataPoints objectAtIndex:i];
	   DL_DataPoint obj2 = [dataPoints objectAtIndex:(i+1)];

        double inst_mpg_avg = (obj1.mpg+obj2.mpg) / 2.0;
        double inst_speed_avg = (obj2.kph + obj2.kph) / 2.0f;

        if (obj2.kph > curr_max_speed) curr_max_speed = obj2.kph;

	   double del_time = [obj2.timestamp timeIntervalSince1970] - [obj1.timestamp timeIntervalSince1970];

        est_gallons_used += del_time * inst_mpg_avg;
        est_miles_traveled += del_time * inst_speed_avg;
    }

    self.total_time = [lastPoint.timestamp timeIntervalSince1970] - [firstPoint.timestamp timeIntervalSince1970];
    self.average_speed = est_miles_traveled / self.total_time;
    self.average_mpg = est_miles_traveled / est_gallons_used;
    self.total_distance = est_miles_traveled;
    self.num_points = count;

/*
	//this Code assumes each call to calcStatistics gives exatly one new data point
    //might be useful in the future
    int count = [dataPoint count];
    DL_DataPoint *lastPoint = [dataPoints lastObject];
    DL_DataPoint *penultPoint = [dataPoints objectAtIndex:(count-1)];
    double del_time = [lastPoint.timestamp timeIntervalSince1970] - [penultPoint.timestamp timeIntervalSince1970];

    self.average_mpg = (self.average_mpg*self.total_time + del_time*lastPoint.mpg) / (self.total_time+del_time);
    if (lastPoint.kph > self.max_speed) {
	    self.max_speed = lastPoint.kph;
    }
    self.average_speed = (self.average_mpg*self.total_time + del_time*lastPoint.mpg) / (self.total_time+del_time);
    self.total_time = self.total_time + del_time;
    self.num_points += 1;
*/

}

+(NSString *)parseClassName {
    return @"DL_Entry";
}

- (NSDictionary *) toDict {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithDouble:self.average_mpg], @"average_mpg",
            [NSNumber numberWithDouble:self.average_speed], @"average_speed",
            [NSNumber numberWithDouble:self.total_distance], @"total_distance",
            [NSNumber numberWithDouble:self.total_time], @"total_time",
            [NSNumber numberWithDouble:self.max_speed], @"max_speed",
            [NSNumber numberWithDouble:[self.startTime timeIntervalSince1970]],@"start_time",
            nil];
}
@end
