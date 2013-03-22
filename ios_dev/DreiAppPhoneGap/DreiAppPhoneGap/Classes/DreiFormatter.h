//
//  DreiFormatter.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//  Modified from code (c) 2012 BMW Group (John Jessen)
//
#import <Foundation/Foundation.h>

@protocol DreiFormatter <NSObject>
+(NSData *)formatCarData:(NSArray *)carData error:(NSError *)error;
+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSString *)formatDataEntryToString:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;

@end
