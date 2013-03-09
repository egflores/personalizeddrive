//
//  DreiDataService.h
//  TemplateBMWApp
//
//  Created by Stephen Trusheim on 3/8/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMWAppKit/BMWAppKit.h>

@interface DreiDataService : NSObject

@property (nonatomic, retain) NSMutableArray * _dataStore;
@property (atomic,retain) NSMutableDictionary * _currentValues;
@property (nonatomic,retain) NSTimer * timer;


-(void)initCurrentValues:(NSArray *)keys;

@end
