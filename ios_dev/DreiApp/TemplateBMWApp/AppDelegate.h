//
//  AppDelegate.h
//  TemplateBMWApp
//
//  Created by John Jessen on 7/30/12.
//  Copyright (c) 2012 BMW Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class BMWManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) BMWManager *manager;
@property (strong, nonatomic) ViewController *viewController;

@end
