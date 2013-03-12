//
//  CDSPropertyDefinesEntertainment_Internal.h
//  BMWAppKit
//
//  Created by Andreas Netzmann on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


/* ************************
 ENTERTAINMENT
 *********************** */

/*!
 @define     entertainment.radioFrequency
 @abstract   Returns only numerical information about the currently tuned station.  To get frequency plus additional information, please see property entertainment.radioStation.
 @discussion Stored in a response key "radioFrequency" as a number in kHz.
 */
extern NSString * const CDSEntertainmentRadioFrequency;

/*!
 @define     entertainment.radioStation
 @abstract   Returns informaiton about the currently playing radio station.  If a RDS name is given, it is returned in the name field.
 @discussion Stored in a response key "radioStation" as a dictionary with keys "frequency", "name", "HDMode", "HDChannel" and "nameInfo".
 "frequency" is a number in kHz.
 "name" is the RDS name of the station and is returned as a string.
 "HDMode" is an enum of type eCDSEntertainmentRadioStationHDMode.
 "HDChannel" is an enum of type eCDSEntertainmentRadioStationHDChannel.
 "nameInfo" is an enum of type eCDSEntertainmentRadioStationNameInfo.
 */
extern NSString * const CDSEntertainmentRadioStation;
enum eCDSEntertainmentRadioStationHDMode
{
    CDSEntertainmentRadioStationHDMode_NO_HD = 0,
    CDSEntertainmentRadioStationHDMode_HYBRID = 1,
    CDSEntertainmentRadioStationHDMode_ALL_DIGITAL = 2
};
enum eCDSEntertainmentRadioStationHDChannel
{
    CDSEntertainmentRadioStationHDChannel_NO_HD_STATION = 0,
    CDSEntertainmentRadioStationHDChannel_1 = 1,
    CDSEntertainmentRadioStationHDChannel_2 = 2,
    CDSEntertainmentRadioStationHDChannel_3 = 3,
    CDSEntertainmentRadioStationHDChannel_4 = 4,
    CDSEntertainmentRadioStationHDChannel_5 = 5,
    CDSEntertainmentRadioStationHDChannel_6 = 6,
    CDSEntertainmentRadioStationHDChannel_7 = 7,
    CDSEntertainmentRadioStationHDChannel_8 = 8
};
enum eCDSEntertainmentRadioStationNameInfo
{
    CDSEntertainmentRadioStationNameInfo_NO_RDS = 0,
    CDSEntertainmentRadioStationNameInfo_RDS_INFO = 1,
    CDSEntertainmentRadioStationNameInfo_CUSTOMER_SPECIFIED = 4,
    CDSEntertainmentRadioStationNameInfo_HD_NAME = 6
};


