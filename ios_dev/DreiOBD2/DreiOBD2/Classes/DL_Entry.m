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
    
    for (DL_DataPoint *dp in dataPoints) {
        num_points += 1;
        running_avg_mpg += dp.mpg; // TODO: THIS IS NOT A THING - @brycecr
        running_total_distance += 0; // TODO: MAKE DISTANCE A THING @brycecr
        if (dp.kph > curr_max_speed) curr_max_speed = dp.kph;
        running_avg_speed += dp.kph;
    }
    
    running_avg_speed /= num_points;
    running_avg_mpg /= num_points;
    
    self.total_distance = -1; // @brycecr - GPS to distance?
    
    // total time = timestamp of end - timestamp of start
    DL_DataPoint *firstPoint = [dataPoints objectAtIndex:0];
    DL_DataPoint *lastPoint = [dataPoints lastObject];
    self.total_time = [lastPoint.timestamp timeIntervalSince1970] - [firstPoint.timestamp timeIntervalSince1970];
    
    self.average_mpg = running_avg_mpg;
    self.average_speed = running_avg_speed;
    self.max_speed = curr_max_speed;
    self.total_distance = running_total_distance;
    self.num_points = num_points;
    
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
