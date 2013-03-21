//
//  BMWGlympseVC.m
//  TemplateName
//
//  Created by John Jessen on 6/5/12.
//  Copyright (c) 2012 BMW Group. All rights reserved.
//

#import "PDView.h"
#import "BMWViewProvider.h"
#import <BMWAppKit/BMWAppKit.h>

@implementation PDView

- (void)viewWillLoad:(IDView *)view
{
    
    // Setup application itself
    self.title = @"PersonalizedDrive";
    
    IDLabel *statusLabel = [IDLabel label];
    statusLabel.text = @"No Drive Log";
    statusLabel.isInfoLabel = true;
    statusLabel.selectable = false;
    
    IDButton *toggleButton = [IDButton button];
    toggleButton.text = @"Start Logging Drive";
    toggleButton.imageData = [self.application.imageBundle imageWithName:@"startButton" type:@"png"];
    [toggleButton setTarget:self selector:@selector(buttonPressed) forActionEvent:IDActionEventSelect];
    
    self.widgets = [NSArray arrayWithObjects:
                    statusLabel,
                    toggleButton,
                    nil];
}

static NSString *nextAction = nil;

- (void)buttonPressed
{
    if (nextAction == nil || [nextAction compare:@"start"] == 0) {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"stopButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Stop Logging Drive"];
        nextAction = @"stop";
    } else if ([nextAction compare:@"stop"] == 0) {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"uploadButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Upload Drive Log"];
        nextAction = @"upload";
    } else if ([nextAction compare:@"upload"] == 0) {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"uploadButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Start Drive Log"];
        nextAction = @"start";
    }
}

@end
