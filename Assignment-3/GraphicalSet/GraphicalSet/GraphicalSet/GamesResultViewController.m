//
//  GamesResultViewController.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "GamesResultViewController.h"
#import "GameResult.h"

@interface GamesResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *setScoresTextDisplay;

@end

@implementation GamesResultViewController

- (void)setup
{
    // Custom initialization
}

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

// Notifies the view controller that its view is about to be added to a view hierarchy.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

// Renders the complete user interface.
- (void)updateUI
{
    NSMutableString *displayText = [[NSMutableString alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd YYYY"];
    for (GameResult *result in [GameResult resultsForGame:[GameResult cardMatchGameName]])
    {
        [displayText appendFormat:@"Card Game %d points / %g sec / %@\n", result.score, round(result.duration), [formatter stringFromDate:result.end]];
        //NSLog(@"%@%i",result, result.score);
    }
    self.setScoresTextDisplay.text = (displayText.length > 0) ? displayText : @"No scores";
    //[displayText setString:@""];
    for (GameResult *result in [GameResult resultsForGame:[GameResult setGameName]])
    {
        [displayText appendFormat:@"Set Game %d points / %g sec / %@\n", result.score, round(result.duration), [formatter stringFromDate:result.end]];
    }
    self.setScoresTextDisplay.text = (displayText.length > 0) ? displayText : @"No scores";
}

@end
