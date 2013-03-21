//
//  DreiSendData.h
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/10/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMWAppKit/BMWAppKit.h>

@interface DreiCarLogger: NSObject

- (id) initWithCDS:(IDCdsService *)cdsService;
- (void) updateCDS:(IDCdsService *)cdsService;
- (void) uploadData;
- (void) startCollection;
- (void) stopCollection;
- (void) clearData;

@end
