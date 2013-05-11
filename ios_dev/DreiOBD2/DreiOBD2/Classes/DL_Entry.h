//
//  DL_Entry.h
//  DreiOBD2
//
//  Created by Stephen Trusheim on 5/10/13.
//
//

#import <Parse/PFObject+Subclass.h>

@interface DL_Entry : PFObject<PFSubclassing>

@property NSDate *startTime;
@property PFUser *user;

// properties that we'll fill in
@property float average_mpg;
@property float total_distance;
@property float total_time;
@property float max_speed;
@property float average_speed;
@property int num_points;

-(id)init;

-(NSDictionary *)toDict;

+(NSString *)parseClassName;

-(void) calcStatistics:(NSArray *)dataPoints;

@end
