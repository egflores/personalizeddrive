//
//  CDSPropertyDefinesVehicle_Internal.h
//  BMWAppKit
//
//  Created by Andreas Netzmann on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/* ************************
 VEHICLE
 *********************** */

/*!
 @define     vehicle.country
 @abstract   Returns information regarding the country selection of the vehicle (where it was conifigured during purchase)
 @discussion Stored in a response key "country" as an enumeration with the possible values:
 CDSVehicleCountry_MALAYSIA
 CDSVehicleCountry_INDIA
 CDSVehicleCountry_TAIWAN
 CDSVehicleCountry_CANADA
 CDSVehicleCountry_SOUTHAFRICA
 CDSVehicleCountry_MIDDLEEAST
 CDSVehicleCountry_EGYPT
 CDSVehicleCountry_BRAZIL
 CDSVehicleCountry_KOREA
 CDSVehicleCountry_AUSTRALIA
 CDSVehicleCountry_JAPAN
 CDSVehicleCountry_ENGLAND
 CDSVehicleCountry_DEUTSCHLAND
 CDSVehicleCountry_USA
 CDSVehicleCountry_ECE
 CDSVehicleCountry_NOCOUNTRY
 CDSVehicleCountry_HONGKONG
 CDSVehicleCountry_CHINA
 CDSVehicleCountry_BELGIUM
 CDSVehicleCountry_MEXICO
 CDSVehicleCountry_VIETNAM
 CDSVehicleCountry_PHILIPPINES
 CDSVehicleCountry_INDONESIA
 CDSVehicleCountry_THAILAND
 CDSVehicleCountry_INVALID
 */
extern NSString * const CDSVehicleCountry;
enum eCDSVehicleCountry
{
    CDSVehicleCountry_NOCOUNTRY = 0,
    CDSVehicleCountry_ECE = 1,
    CDSVehicleCountry_USA = 2,
    CDSVehicleCountry_DEUTSCHLAND = 3,
    CDSVehicleCountry_ENGLAND = 4,
    CDSVehicleCountry_JAPAN = 5,
    CDSVehicleCountry_AUSTRALIA = 6,
    CDSVehicleCountry_KOREA = 7,
    CDSVehicleCountry_BRAZIL = 8,
    CDSVehicleCountry_EGYPT = 9,
    CDSVehicleCountry_MIDDLEEAST = 10,
    CDSVehicleCountry_SOUTHAFRICA = 11,
    CDSVehicleCountry_CANADA = 12,
    CDSVehicleCountry_TAIWAN = 13,
    CDSVehicleCountry_INDIA = 14,
    CDSVehicleCountry_MALAYSIA = 15,
    CDSVehicleCountry_THAILAND = 16,
    CDSVehicleCountry_INDONESIA = 17,
    CDSVehicleCountry_PHILIPPINES = 18,
    CDSVehicleCountry_VIETNAM = 19,
    CDSVehicleCountry_MEXICO = 20,
    CDSVehicleCountry_BELGIUM = 21,
    CDSVehicleCountry_CHINA = 22,
    CDSVehicleCountry_HONGKONG = 23,
    CDSVehicleCountry_INVALID = 255
};

/*!
 @define     vehicle.systemTime
 @abstract   This returns information regarding the acutal system time (vehicle time master) of the vehicle in seconds after TODO - after when . . 1970??
 @discussion Stored in response key "systemTime" as a number.
 NOTE: This property does not currently support GET, only BIND. 
 */
extern NSString * const CDSVehicleSystemTime;

/*!
 @define     vehicle.VIN
 @abstract   This returns the last 7 digits of the vehicle's VIN number.  Each number is stored as number and represents an ASCII character.  
 @discussion Stored in response key "VIN" as a dictionary with keys: "1", "2", "3", "4", "5", "6", "7"
 */
extern NSString * const CDSVehicleUnitVIN;


