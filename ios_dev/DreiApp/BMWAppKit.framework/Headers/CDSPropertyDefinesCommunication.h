//
//  BMW Group App Integration Framework
//
//  Created by Jeff Zabel on 10/29/09.
//  Copyright 2009 BMW. All rights reserved.
//

/* ************************
 COMMUNICATION
 *********************** */

/*!
 @define     communication.currentCallInfo
 @abstract   Returns the name and number of the current call.
 @discussion Stored in a response key "currentCallInfo" as a dictionary with keys "name" and "number".  Both values are strings.
 */
extern NSString * const CDSCommunicationCurrentCallInfo;

/*!
 @define     communication.lastCallInfo
 @abstract   Returns the name and number of the last call.
 @discussion Stored in a response key "lastCallInfo" as a dictionary with keys "name" and "number".  Both values are strings.
 */
extern NSString * const CDSCommunicationLastCallInfo;

