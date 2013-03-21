//
//  DreiUploader.h
//  TemplateBMWApp
//
//  Created by Rowan Chakoumakos on 3/8/13.
//  Copyright (c) 2013 BMW Group. All rights reserved.
//

#ifndef TemplateBMWApp_DreiUploader_h
#define TemplateBMWApp_DreiUploader_h

@interface DreiUploader : NSObject

-(DreiUploader *)initWithEndPoint:(NSURL *)urlEndPoint;
-(void)postJSON:(NSData *)json toURL:(NSURL *)url error:(NSError *) error;
-(void)formatAndPost:(NSArray *)carData toURL:(NSURL *)url error:(NSError *)error;

@end

#endif
