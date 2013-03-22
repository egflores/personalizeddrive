//
//  DreiBMWDataService.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//


#import <Foundation/Foundation.h>
#import "DreiDataService.h"
#import <BMWAppKit/BMWAppKit.h>

/* The RealDataService grabs data from the BMW CDS API and posts it in ways compatible with the DreiDataService.
 * You must initalize using initWithCDS - otherwise nothing will work.
 */
@interface DreiBMWDataService : DreiDataService

@property (atomic,retain) IDCdsService * _cdsService;

- (id)initWithCDS:(IDCdsService *) cdsService;

@end
