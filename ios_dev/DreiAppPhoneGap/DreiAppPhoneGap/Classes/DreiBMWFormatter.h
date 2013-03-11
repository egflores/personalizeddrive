//
//  DreiBMWFormatter.h
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreiFormatter.h"

@interface DreiBMWFormatter : NSObject <DreiFormatter>
+(NSData *)formatCarData:(NSArray *)carData error:(NSError *)error;
+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
    
@end
