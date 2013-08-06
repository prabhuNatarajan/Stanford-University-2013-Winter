//
//  GameSettingsViewController.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GameSettingsViewController.h"
#import "GameResult.h"

@interface GameSettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLabel;

@end

@implementation GameSettingsViewController

- (void)setup
{
    // Custom initialization
}

// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
- (void)awakeFromNib
{
    [self setup];
}

// Returns a newly initialized view controller with the nib file in the specified bundle.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        [self setup];
    }
    return self;
}

// Called after the controller’s view is loaded into memory.
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Set the main view's background color
    self.view.backgroundColor = [UIColor underPageBackgroundColor];    
    // Engrave the labels
    [self engraveLabel:self.settingsLabel];
    [self engraveLabel:self.appNameLabel];
    [self engraveLabel:self.copyrightLabel];
}

// Applies an engraving effect to the given label.
- (void)engraveLabel:(UILabel *)label
{
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
}

// Resets the game scores.
- (IBAction)resetScores:(UIButton *)sender
{
    [GameResult resetAllGameResults];
}

@end
