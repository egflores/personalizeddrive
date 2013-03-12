//
//  CDSPropertyDefinesSensors_Internal.h
//  BMWAppKit
//
//  Created by Andreas Netzmann on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/* **********************
 SENSORS
 ************************ */
/*!
 @define     sensors.battery
 @abstract   A status of the vehicle's battery charge in percentage of full.
 @discussion Stored in response key "battery" as a number (percentage).
 */
extern NSString * const CDSSensorsBattery;

/*!
 @define     sensors.crash
 @abstract   A status representing information regarding if the vehicle has been in a crash or not and the severity of the crash if one has occured.  Crash 1 being the least severe to Crash 4 being the most severe.
 @discussion Stored in response key "crash" as a enumeration with the following values: CDSSensorsCrash_NOCRASH, CDSSensorsCrash_CRASH1, CDSSensorsCrash_CRASH2, CDSSensorsCrash_CRASH3, CDSSensorsCrash_CRASH4, CDSSensorsCrash_INVALID
 */
extern NSString * const CDSSensorsCrash;
enum eCDSSensorsCrash
{
    CDSSensorsCrash_NOCRASH = 0,
    CDSSensorsCrash_CRASH1 = 1,
    CDSSensorsCrash_CRASH2 = 2,
    CDSSensorsCrash_CRASH3 = 3,
    CDSSensorsCrash_CRASH4 = 4,
    CDSSensorsCrash_INVALID = 15
};

/*!
 @define     sensors.doors
 @abstract   This signal returns information about the status of the driver, passenger, driver rear, passenger rear door states (open or closed)
 @discussion Stored in response key "doors" as dictionary with keys "driver", "passenger", "driverRear" and "passengerRear".  All are enumerations with the following values: 
 CDSSensorsDoor_CLOSED, CDSSensor_OPEN, CDSSensorsDoor_INVALID
 */
extern NSString * const CDSSensorsDoors;
enum eCDSSensorsDoors
{
    CDSSensorsDoor_CLOSED = 0,
    CDSSensorsDoor_OPEN = 1,
    CDSSensorsDoor_INVALID = 2
};

/*!
 @define     sensors.PDCRangeFront
 @abstract   This signal gives information regarding the range to a detected object from the front Park Distance Control (PDC) System.  
 @discussion Stored in response key "PDCRangeFront" as a dictionary with keys "outLeft", "left", "middleLeft", "middleRight", "right" and "outRight".
 Distance is measured in cm when the value is 0-252. 253 represents no object detected. 254 represents the sensor not being active. 255 represents an invalid signal.
 */
extern NSString * const CDSSensorsPDCRangeFront;

/*!
 @define     sensors.PDCRangeRear
 @abstract   This signal gives information regarding the range to a detected object from the rear Park Distance Control (PDC) System.  
 @discussion Stored in response key "PDCRangeRear" as a dictionary with keys "outLeft", "left", "middleLeft", "middleRight", "right" and "outRight". Distance is measured in cm when the value is 0-252. 253 represents no object detected. 254 represents the sensor not being active. 255 represents an invalid signal. 
 */
extern NSString * const CDSSensorsPDCRangeRear;


/*!
 @define     sensors.PDCStatus
 @abstract   This signal gives information regarding the status of the activation state of the Park Distance Control (PDC) System.  
 @discussion Stored in response key "PDCStatus" as a enumeration with possible values: CDSSenorsPDCStatus_OFF, CDSSensorsPDCStatus_ON, CDSSensorsPDCStatus_INVALID
 */
extern NSString * const CDSSensorsPDCStatus;
enum eCDSSensorsPDCStatus
{
    CDSSensorsPDCStatus_RESERVED = 0,
    CDSSensorsPDCStatus_OFF = 2,
    CDSSensorsPDCStatus_ON = 1,
    CDSSensorsPDCStatus_INVALID = 3
};

/*!
 @define     sensors.rain
 @abstract   This signal gives information from the rain sensor regarding the current strength of the rain.
 @discussion Stored in response key "rain" as a number
 */
extern NSString * const CDSSensorsRain;

/*!
 @define     sensors.seatbelt
 @abstract   This represents the status of the driver's seatbelt. 
 @discussion Stored in response key "seatbelt" as a dictionary with keys "driverFront", "passengerFront", "driverRear",  "passengerRear" and "centerRear".  
 All are enumerations with the following possible values: CDSSensorsSeatbelt_BUCKLED, CDSSensorsSeatbelt_UNBUCKLED, CDSSensorsSeatbelt_INVALID
 */
extern NSString * const CDSSensorsSeatbelt;
enum eCDSSensorsSeatbelt
{
    CDSSensorsSeatbelt_UNBUCKLED = 0,
    CDSSensorsSeatbelt_BUCKLED = 1,
    CDSSensorsSeatbelt_INVALID = 3,
    CDSSensorsSeatbelt_NOTCODED = 2
};

/*!
 @define     sensors.seatOccupiedDriver
 @abstract   This represents the occupancy status of the driver's seat. 
 @discussion Stored in response key "seatOccupiedDriver" as an enumeration with possible values of eCDSSensorsSeatOccupied.
 */
extern NSString * const CDSSensorsSeatOccupiedDriver;
enum eCDSSensorsSeatOccupied
{
    CDSSensorsSeatOccupiedPassenger_UNOCCUPIED = 0,
    CDSSensorsSeatOccupiedPassenger_CHILDSEAT = 1,      // only meaningful for SeatOccubiedPassenger
    CDSSensorsSeatOccupiedPassenger_OCCUPIED = 3,
    CDSSensorsSeatOccupiedPassenger_UNAVAILABLE = 4,
    CDSSensorsSeatOccupiedPassenger_INITIALVALUE = 6,
    CDSSensorsSeatOccupiedPassenger_INVALID = 7
};

/*!
 @define     sensors.seatOccupiedRearLeft
 @abstract   This represents the occupancy status of the rear left seat. 
 @discussion Stored in response key "CDSSensorsSeatOccupiedRearLeft" as an enumeration with possible values of eCDSSensorsSeatOccupied.
 */
extern NSString * const CDSSensorsSeatOccupiedRearLeft;

/*!
 @define     sensors.seatOccupiedRearRight
 @abstract   This represents the occupancy status of the rear right seat. 
 @discussion Stored in response key "CDSSensorsSeatOccupiedRearRight" as an enumeration with possible values of eCDSSensorsSeatOccupied.
 */
extern NSString * const CDSSensorsSeatOccupiedRearRight;

/*!
 @define     sensors.seatOccupiedPassenger
 @abstract   This represents the occupancy status of the passenger's seat. 
 @discussion Stored in response key "seatOccupiedPassenger" as an enumeration with possible values of eCDSSensorsSeatOccupiedPassenger.
 */
extern NSString * const CDSSensorsSeatOccupiedPassenger;

/*!
 @define     sensors.temperatureExterior
 @abstract   This signal represents the value of the current outside temperature in degrees C.
 @discussion Stored in response key "temperatureExterior" as a number.
 */
extern NSString * const CDSSensorsTemperatureExterior;

/*!
 @define     sensors.temperatureInterior
 @abstract   This signal represents the value of the current interior temperature in degrees C.
 @discussion Stored in response key "temperatureInterior" as a number.
 */
extern NSString * const CDSSensorsTemperatureInterior;

/*!
 @define     sensors.tirePressureWarning
 @abstract   This signal gives information regarding if there is a tire that is underinflated or is flat.
 @discussion Stored in response key "tirePressureWarning" as a dictionary with key "status". "status" is an enumeration with possible values: CDSSenorsTirePressureWarning_NONE, CDSSenorsTirePressureWarning_WARNING, CDSSenorsTirePressureWarning_INVALID
 */
extern NSString * const CDSSensorsTirePressureWarning;
enum eCDSSensorsTirePressureWarning
{
    CDSSensorsTirePressureWarning_NONE = 0,
    CDSSensorsTirePressureWarning_WARNING = 1,
    CDSSensorsTirePressureWarning_INVALID = 2
};

/*!
 @define     sensors.trunk
 @abstract   This signal gives information regarding if the trunk door is open or closed.
 @discussion Stored in response key "trunk" as a enumeration with possible values: CDSSenorsTrunk_OPEN, CDSSenorsTrunk_CLOSED, CDSSenorsTrunk_INVALID
 //TODO Check with actual ENUM VALUES
 */
extern NSString * const CDSSensorsTrunk;
enum eCDSSensorsTrunk
{
    CDSSensorsTrunk_CLOSED = 0,
    CDSSensorsTrunk_OPEN = 1,
    CDSSensorsTrunk_INVALID = 2
};

/*!
 @define        sensors.lid
 @abstract      This signal returns information about the lid of the car.
 @discussion    Stored in response key "lid" as enum. Possible values: CDSSensorsLid_CLOSED, CDSSensorsLid_OPEN, CDSSensorsLid_UNPLAUSIBLE, CDSSensorsLid_INVALID
 */
extern NSString * const CDSSensorsLid;
enum eCDSSensorsLid
{
    CDSSensorsLid_CLOSED = 0,
    CDSSensorsLid_OPEN = 1,
    CDSSensorsLid_UNPLAUSIBLE = 2,
    CDSSensorsLid_INVALID = 3
};
