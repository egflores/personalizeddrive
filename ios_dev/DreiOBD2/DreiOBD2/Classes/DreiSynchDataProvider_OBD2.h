//
//  DreiSynchDataProvider_OBD2.h
//  BasicScan
//
//  Created by Stephen Trusheim on 4/29/13.
//
//

#import "DreiSynchDataProvider.h"
#import "FLScanTool.h"

@interface DreiSynchDataProvider_OBD2 : DreiSynchDataProvider <FLScanToolDelegate>

@property(atomic,retain) FLScanTool* _scanTool;

@end
