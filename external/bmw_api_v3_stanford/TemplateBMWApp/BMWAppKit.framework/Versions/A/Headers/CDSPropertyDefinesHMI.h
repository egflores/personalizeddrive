//
//  BMW Group App Integration Framework
//
//  Created by Jeff Zabel on 10/29/09.
//  Copyright 2009 BMW. All rights reserved.
//

/* ************************
 HMI
 *********************** */

/*!
 @define     hmi.tts
 @abstract   Returns the text to speech (TTS) state, the current read block and the number of blocks
 @discussion Stored in a response key "TTSState" as a dictionary with keys "state", "currentblock" and "blocks".  Paramters are numbers.
 Possible values for "state" are: 
    ttsUNDEFINED,
    ttsIDLE,        // starting TTS is only allowed by calling play() with a text
    ttsPAUSED,      // like IDLE but current text block is remembered and can be played with togglePauseResume()
    ttsACTIVE,      // currently playing text (or preparing to play text)
    ttsBUSY         // if someone else is currently using TTS or we currently do an internal state transition
 */
extern NSString * const CDSHMITTSState;


/*!
 @define hmi.speedlock
 */
extern NSString * const CDSHMISpeedlock;
enum eCDSHMISpeedlock
{
    CDSHMISpeedlock_Unknown = 0,
    CDSHMISpeedlock_Standing = 1,
    CDSHMISpeedlock_Driving = 2,
    CDSHMISpeedlock_Init = 3
};

extern NSString * const CDSHMIVideolock;
enum eCDSHMIVideolock
{
    CDSHMIVideolock_Unknown = 0,
    CDSHMIVideolock_Enabled = 1,
    CDSHMIVideolock_Disabled = 2
};
