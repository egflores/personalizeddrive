//
//  DreiFormatter.h
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DreiFormatter <NSObject>
+(NSData *)formatCarData:(NSArray *)carData error:(NSError *)error;
+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSString *)formatDataEntryToString:(NSDictionary *)originalDataPoint error:(NSError *)error;
+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error;

@end
