//
//  DreiRealDataService.h
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreiDataService.h"
#import <BMWAppKit/BMWAppKit.h>


@interface DreiRealDataService : DreiDataService

@property (atomic,retain) IDCdsService * _cdsService;

- (id)initWithCDS:(IDCdsService *) cdsService;

@end
