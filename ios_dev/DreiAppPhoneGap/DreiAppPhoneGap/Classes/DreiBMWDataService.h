//
//  DreiRealDataService.h
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
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
