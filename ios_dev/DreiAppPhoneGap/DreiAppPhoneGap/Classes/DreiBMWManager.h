//
//  DreiBMWManager.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//  Modified from code (c) 2012 BMW Group (John Jessen)
//

#import <Foundation/Foundation.h>
#import <BMWAppKit/BMWAppKit.h>

extern NSString* BMWManagerConnectionStateChanged;

enum BMWManagerStatus {
    BMWManagerStatusNotConnected,
    BMWManagerStatusConnectionChanging,
    BMWManagerStatusConnected
} typedef BMWManagerStatus;

/**
 * Simply Alloc/init an instance
 * of this object to start your
 * BMW App listening for a car
 * to connect to.
 */
@interface DreiBMWManager : NSObject
@property(retain, nonatomic) IDApplication* application;

- (BMWManagerStatus)status;

@end
