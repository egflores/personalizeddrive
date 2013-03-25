//
//  DreiUploader.h
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//


#ifndef TemplateBMWApp_DreiUploader_h
#define TemplateBMWApp_DreiUploader_h

@interface DreiUploader : NSObject

-(DreiUploader *)initWithEndPoint:(NSURL *)urlEndPoint;
-(BOOL)postJSON:(NSData *)json toURL:(NSURL *)url error:(NSError *) error;
-(BOOL)formatAndPost:(NSArray *)carData toURL:(NSURL *)url error:(NSError *)error;

@end

#endif
