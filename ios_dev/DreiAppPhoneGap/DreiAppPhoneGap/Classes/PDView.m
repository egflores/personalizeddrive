//
//  PDView.m
//  PersonalizedDriveApp
//
//  Created by SU - BMW Drei
//  Copyright (c) 2013 BMW Drei, per LICENSE
//  Modified from code (c) 2012 BMW Group (John Jessen)
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

static NSString *status = nil;

- (void)buttonPressed
{
    if (status == nil || [status compare:@"noLog"] == 0) {
        // stopped -> start log
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"stopButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Stop Logging Drive"];
        [[self.widgets objectAtIndex:0] setText:@"Logging..."];
        status = @"logging";
    } else if ([status compare:@"logging"] == 0) {
        // logging -> stop log
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"uploadButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Upload Drive Log"];
        [[self.widgets objectAtIndex:0] setText:@"Collected drive log."];
        status = @"saved";
    } else if ([status compare:@"saved"] == 0) {
        [[self.widgets lastObject] setImageData:[self.application.imageBundle imageWithName:@"uploadButton" type:@"png"]];
        [[self.widgets lastObject] setText:@"Start Drive Log"];
        [[self.widgets objectAtIndex:0] setText:@"Drive log saved."];
        status = @"noLog";
    }
}

@end
