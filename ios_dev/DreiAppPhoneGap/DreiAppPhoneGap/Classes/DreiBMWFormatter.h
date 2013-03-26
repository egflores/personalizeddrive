//
//  DreiBMWFormatter.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import <Foundation/Foundation.h>
#import "DreiFormatter.h"

@interface DreiBMWFormatter : NSObject <DreiFormatter>
+(NSData *)formatCarData:(NSArray *)carData error:(NSError *)error;
+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSString *)formatDataEntryToString:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
    
@end
