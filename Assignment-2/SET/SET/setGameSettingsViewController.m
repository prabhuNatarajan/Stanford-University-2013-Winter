//
//  setGameSettingsViewController.m
//  SET
//
//  Created by Apple on 04/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "setGameSettingsViewController.h"
#import "setGamesScores.h"
#import <QuartzCore/QuartzCore.h>

@interface setGameSettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *settingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLabel;

@end

@implementation setGameSettingsViewController

- (void)setup
{
    
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
    [self engraveLabel:self.settingsLabel];
    [self engraveLabel:self.appNameLabel];
    [self engraveLabel:self.copyrightLabel];
}

- (void)engraveLabel:(UILabel *)label
{
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
}

- (IBAction)resetScores:(UIButton *)sender
{
    [setGamesScores resetAllGameResults];
}

@end