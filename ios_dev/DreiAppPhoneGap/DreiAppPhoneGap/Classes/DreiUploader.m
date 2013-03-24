//
//  DreiUploader.m
//  DreiFramework
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//

#import "DreiUploader.h"
#import "DreiBMWFormatter.h"
#import "DreiCarCenter.h"

@implementation DreiUploader

NSURL * _endpoint;

/* initWithEndPoint:
 * -----------------
 * Place holder for setting up oauth with the server
 */
-(DreiUploader *)initWithEndPoint:(NSURL *)urlEndPoint {
    if(self == [super init]) {
        _endpoint = urlEndPoint;
    }
    return self;
}

/* postJSON:toURL:
 * ---------------
 * Posts the JSON payload to the server. 
 *
 * Example usage:
 * NSString *bodyData = @"{'Example':'json'}";
 * NSURL *url = [NSURL URLWithString:@"http://requestb.in/18969rm1"];
 * DreiUploader * uploader = [[[DreiUploader alloc] init] retain];
 * [uploader postJSON:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]] toURL: url];
 *
 *
 * This should be replaced with a combination of
 * https://github.com/AFNetworking/AFNetworking
 * and https://github.com/RestKit/RestKit to provide
 * more robust handling of errors.  Currently, this method
 * would require delegation instead of blocks.
 */
-(BOOL)postJSON:(NSData *)json toURL:(NSURL *)url error:(NSError *)error {
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Set the post to json
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [postRequest setHTTPBody:json];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];
    
    // TODO: DOES THIS ACTUALLY WORK? IT WORKED WHEN I DIDNT HAVE INTERNET... SOMETHING ISNT RIGHT
    if (connection) {
        // The connection was established.
        //_receivedData = [[NSMutableData data] retain];
        [DreiCarCenter debug:@"Connection succeeded - upload successful" from:@"uploader" jsonMessage:false];
        [[DreiCarCenter instance] sendMessage:@"success" toCallback:@"upload"];
        return true;
    }
    else
    {
        // The download could not be made.
        [[DreiCarCenter instance] sendMessage:@"fail" toCallback:@"upload"];
        [DreiCarCenter debug:[NSString stringWithFormat:@"Upload to endpoint failed: %@", @"Unknown"]
                        from:@"uploader"
                 jsonMessage:false];
        return false;
    }
}

-(BOOL)formatAndPost:(NSArray *)carData toURL:(NSURL *)url error:(NSError *)error {
    NSData * carDataJson = [DreiBMWFormatter formatCarData:carData error:error];
    return [self postJSON:carDataJson toURL:url error:error];
}

@end
