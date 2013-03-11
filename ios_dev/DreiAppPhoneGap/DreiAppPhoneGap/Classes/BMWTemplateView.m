//
//  BMWGlympseVC.m
//  TemplateName
//
//  Created by John Jessen on 6/5/12.
//  Copyright (c) 2012 BMW Group. All rights reserved.
//

#import "BMWTemplateView.h"
#import "BMWViewProvider.h"
#import "DreiFakeDataService.h"
#import "DreiBMWFormatter.h"
#import "DreiUploader.h"
#import "DreiSendData.h"
#import <BMWAppKit/BMWAppKit.h>

@implementation BMWTemplateView




- (void)viewWillLoad:(IDView *)view
{
    DreiSendData * dataSender = [[DreiSendData alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:5 target:dataSender selector:@selector(sendDataToServer) userInfo:nil repeats:true];
    
    
    self.title = @"Template Title";
    
    IDLabel *label = [IDLabel label];
    label.text = @"Template Label";
    
    IDButton *button1 = [IDButton button];
    button1.text = @"Template Button";
    button1.imageData = [self.application.imageBundle imageWithName:@"bmwLogo" type:@"png"];
    [button1 setTarget:self selector:@selector(buttonPressed) forActionEvent:IDActionEventFocus];
    
    //    [self.application.imageBundle imageWithName:@"otherImage" type:@"png"];
    
    IDImage *image = [IDImage image];
    image.imageData = [self.application.imageBundle imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bmw" ofType:@"jpg"]]];
    image.position = CGPointMake(100, 150);
    
    self.widgets = [NSArray arrayWithObjects:
                    label,
                    button1,
                    image,
                    nil];
}

static int counter = 0;

- (void)buttonPressed
{
    if (counter % 2 == 0) {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scrat-bmw" ofType:@"jpg"]]]];
    } else {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"bmw" type:@"jpg"]];
        
    }
    
    
    counter++;
}

@end
