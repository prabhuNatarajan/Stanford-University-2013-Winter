//
//  setGamesScoresViewController.m
//  SET
//
//  Created by Apple on 04/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "setGamesScoresViewController.h"
#import "setGamesScores.h"

@interface setGamesScoresViewController ()

@property (weak, nonatomic) IBOutlet UITextView *cardMatchScoresTextDisplay;
@property (weak, nonatomic) IBOutlet UITextView *setScoresTextDisplay;

@end

@implementation setGamesScoresViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    NSMutableString *displayText = [[NSMutableString alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd YYYY"];
    for (setGamesScores *result in [setGamesScores resultsForGame:[setGamesScores cardMatchingGameName]])
    {
        [displayText appendFormat:@"%d points / %g sec / %@ \n", result.score, round(result.duration), [formatter stringFromDate:result.end]];
    }
    self.cardMatchScoresTextDisplay.text = (displayText.length > 0) ? displayText : @"NO Scores";
    [displayText setString:@""];
    for (setGamesScores *result in [setGamesScores resultsForGame:[setGamesScores setGameName]])
    {
        [displayText appendFormat:@"%d points / %g sec / %@ \n", result.score, round(result.duration), [formatter stringFromDate:result.end]];
    }
    self.setScoresTextDisplay.text = (displayText.length > 0) ? displayText : @"NO Scores";
}

@end