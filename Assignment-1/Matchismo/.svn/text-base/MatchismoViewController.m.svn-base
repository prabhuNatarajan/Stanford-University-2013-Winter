//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoViewController.h"
#import "MatchismoPlayingCardDeck.h"
#import "MatchismoCardMatchingGame.h"

@interface MatchismoViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) MatchismoCardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *messageSlider;

@end

@implementation MatchismoViewController

- (MatchismoCardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[MatchismoCardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[MatchismoPlayingCardDeck alloc]init] matchCount:(self.gameModeSegmentedControl.selectedSegmentIndex + 2)];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        MatchismoCard *card = [self.game cardAtindex:[self.cardButtons indexOfObject:cardButton]];
        UIImage *cardImage = [UIImage imageNamed:@"images.jpeg"];
        UIImage *cardTemplate = [UIImage imageNamed:@"image.jpeg"];
        [cardButton setBackgroundImage:cardImage forState:UIControlStateNormal];
        [cardButton setBackgroundImage:cardTemplate forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.unplayable;
        cardButton.alpha = card.isUnplayable ? 0.8 : 1.0;
    }
    // Update the score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    // Display the last game message and update the message slider
    [self displayMessage:0];
    self.messageSlider.minimumValue = (self.game.messageCount > 0) ? (float)(self.game.messageCount - 1) * -1.0f : 0.0f;
    [self.messageSlider setValue:self.messageSlider.maximumValue animated:!(self.messageSlider.value == self.messageSlider.maximumValue)];
    // Toggle the match mode control based on whether a game has already been started
    self.gameModeSegmentedControl.enabled = !(self.flipCount > 0);
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    //button animation
    [UIView transitionWithView:sender
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ sender.highlighted = YES; }
                    completion:nil];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = (int)flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d", self.flipCount];
}

// Shows a game message string.
- (void)displayMessage:(NSUInteger )index
{
    self.resultLabel.text = (self.game.messageCount > 0) ? [self.game messageAtIndex:index] : @"flip a card!";
    self.resultLabel.alpha = (index == 0) ? 1.0 : 0.8;
}

- (IBAction)scrubMessages:(UISlider *)sender
{
    float stepValue = floorf(sender.value + 0.5f);
    self.messageSlider.value = stepValue;
    [self displayMessage:(int)(stepValue * -1.0f)];

}

- (IBAction)dealButton
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)gameModeSegmentedControl:(UISegmentedControl *)sender
{
    [self.game setMatchCount:(sender.selectedSegmentIndex +2)];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgrounds.jpeg"]];
}

@end
