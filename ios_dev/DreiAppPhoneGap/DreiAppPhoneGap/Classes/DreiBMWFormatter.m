//
//  DreiBMWFormatter.m
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
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
        NSLog(@"%@", formattedCarData);
    }
    NSDictionary * dataToSend = [NSDictionary dictionaryWithObject:formattedCarData forKey:@"data"];
    return [NSJSONSerialization dataWithJSONObject:dataToSend
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}

+(NSMutableDictionary *)convertDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error {
    NSMutableDictionary * formattedDataPoint = [[NSMutableDictionary alloc] initWithCapacity:[originalDataPoint count]];
    formattedDataPoint[@"car_id"] = [NSNumber numberWithInt:1]; //TODO: Remove hardcoded number.  Blocking on accessing VIN number.
    
    if(originalDataPoint[@"headlights"] == 0) {
        formattedDataPoint[@"headlights"] = @"yes";
    } else {
        formattedDataPoint[@"headlights"] = @"no";
    }
    
    formattedDataPoint[@"odometer"] = originalDataPoint[@"odometer"];
    formattedDataPoint[@"speed"] = originalDataPoint[@"speedActual"];
    switch ((int)originalDataPoint[@"engine_status"]) {
        case CDSEngineStatus_OFF:
            formattedDataPoint[@"engine_status"] = @"off";
            break;
            
        case CDSEngineStatus_STARTING:
            formattedDataPoint[@"engine_status"] = @"starting";
            break;
            
        case CDSEngineStatus_RUNNING:
            formattedDataPoint[@"engine_status"] = @"running";
            break;
            
        case CDSEngineStatus_INVALID:
            formattedDataPoint[@"engine_status"] = @"invalid";
            break;
    }
    //formattedDataPoint["navigation_destinations"]; TODO: Version 1.01...if we want them
    formattedDataPoint[@"fuel_level"] = originalDataPoint[@"fuel_level"];
    formattedDataPoint[@"fuel_range"] = originalDataPoint[@"fuel_range"];
    
    
    switch ((int)originalDataPoint[@"fuel_reserve"]) {
        case CDSSensorsFuelReserve_NO:
            formattedDataPoint[@"fuel_reserve"] = @"no";
            break;
            
        case CDSSensorsFuelReserve_YES:
            formattedDataPoint[@"fuel_reserve"] = @"yes";
            break;
            
        case CDSSensorsFuelReserve_INVALID:
            formattedDataPoint[@"fuel_reserve"] = @"invalid";
            break;
    }
    
    formattedDataPoint[@"timestamp"] = originalDataPoint[@"time"];
    return formattedDataPoint;
}

+(NSData *)formatDataEntry:(NSDictionary *)originalDataPoint error:(NSError *)error {
    NSMutableDictionary * formattedDataPoint = [DreiBMWFormatter convertDataEntry:originalDataPoint error:error];
    return [NSJSONSerialization dataWithJSONObject:formattedDataPoint
                                           options:NSJSONWritingPrettyPrinted
                                             error:&error];
}

+(NSString *)formatDataEntryToString:(NSDictionary *)originalDataPoint error:(NSError *)error {
    return[[NSString alloc] initWithData:[DreiBMWFormatter formatDataEntry:originalDataPoint error:error] encoding:NSUTF8StringEncoding];
}
@end
