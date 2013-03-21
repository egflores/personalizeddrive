//
//  BMWViewProvider.h
//  TemplateName
//
//  Created by Philip Johnston on 4/6/12.
//  Copyright (c) 2012 BMW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMWAppKit/BMWAppKit.h>
#import "PDView.h"

@interface BMWViewProvider : NSObject <IDHmiProvider>
@property(nonatomic, retain) IDMultimediaInfo* multimediaInfo;
@property(nonatomic, retain) IDStatusBar* statusBar;


@property (nonatomic, retain) PDView *pdView;


@end
