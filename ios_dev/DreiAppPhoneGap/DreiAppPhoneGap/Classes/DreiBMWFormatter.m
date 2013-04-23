//
//  DreiBMWFormatter.m
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//


#import "DreiBMWFormatter.h"
#import <BMWAppKit/BMWAppKit.h>

@implementation DreiBMWFormatter

/* formatCarData:error:
 * --------------
 * Takes an NSArray of NSDictionaries and converts it to
 * JSON data that abides to the Drei API.
 *
 * ~~~~
 * TODO: In future, convert all units to standard units.
 */
+(NSData *)formatCarData:(NSArray *)carData error:(NSError *)error {
    NSMutableArray * formattedCarData = [[NSMutableArray alloc] initWithCapacity:[carData count]];
    for (NSDictionary * originalDataPoint in carData) {
        NSMutableDictionary * formattedDataPoint = [DreiBMWFormatter convertDataEntry:originalDataPoint error:error];
        [formattedCarData addObject:formattedDataPoint];
    }
    NSDictionary * dataToSend = [NSDictionary dictionaryWithObject:formattedCarData forKey:@"data"];
    return [NSJSONSerialization dataWithJSONObject:dataToSend
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}

+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error {
    return [originalDataPoint mutableCopy];
    // all data output by DreiDataService is now JSON-friendly
}

+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error {
    NSMutableDictionary * formattedDataPoint = [DreiBMWFormatter convertDataEntry:originalDataPoint error:error];
    return [NSJSONSerialization dataWithJSONObject:formattedDataPoint
                                           options:0
                                             error:&error];
}

+(NSString *)formatDataEntryToString:(NSDictionary *)originalDataPoint error:(NSError *)error {
    return[[NSString alloc] initWithData:[DreiBMWFormatter formatDataEntry:originalDataPoint error:error] encoding:NSUTF8StringEncoding];
}
@end
