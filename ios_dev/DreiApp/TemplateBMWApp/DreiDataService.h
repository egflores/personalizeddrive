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

@property (atomic, retain) NSMutableArray * _dataStore;
@property (atomic,retain) NSMutableDictionary * _currentValues;
@property (atomic,retain) NSTimer * timer;


-(void)initCurrentValues:(NSArray *)keys;
-(void)startCollection;
-(NSArray *)getDataKeys;


@end
