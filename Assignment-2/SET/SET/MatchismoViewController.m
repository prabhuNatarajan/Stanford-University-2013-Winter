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
#import "setGamesScores.h"

@interface MatchismoViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) MatchismoCardMatchingGame *game;
@property (strong, nonatomic) setGamesScores *gameResult;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISlider *messageSlider;

@end

@implementation MatchismoViewController

- (MatchismoCardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[MatchismoCardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[self newDeck]];
    }
    return _game;
}

// Returns a game result instance.
- (setGamesScores *)gameResult
{
    if (!_gameResult)
    {
        _gameResult = [[setGamesScores alloc] initWithName:[self gameName]];
    }
    return _gameResult;
}

// Returns the name of the game.
- (NSString *)gameName
{
    return [setGamesScores cardMatchingGameName];
}

// Returns a new deck of cards.
- (MatchismoDeck *)newDeck
{
    return [[MatchismoPlayingCardDeck alloc] init];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        MatchismoCard *card = [self.game cardAtindex:[self.cardButtons indexOfObject:cardButton]];
        [self renderCardButton:cardButton card:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    // Display the last game message and update the message slider accordingly
    [self displayMessage:0];
    self.messageSlider.minimumValue = (self.game.messageCount > 0) ? -(float)(self.game.messageCount - 1) : 0.0f;
    [self.messageSlider setValue:self.messageSlider.maximumValue animated:!(self.messageSlider.value == self.messageSlider.maximumValue)];
}

//Render a card button.
- (void)renderCardButton:(UIButton *)cardButton card:(MatchismoCard *)card
{
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = (card.isUnplayable) ? 0.3f : 1.0f;
    [cardButton setBackgroundImage:(cardButton.selected) ? [UIImage imageNamed:@"image.jpeg"] : [UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    //button animation
    [UIView transitionWithView:sender
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ sender.highlighted = YES; }
                    completion:nil];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = (int)flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d", self.flipCount];
}

// Shows a game message string.
- (void)displayMessage:(NSUInteger)index
{
    NSString *message = (self.game.messageCount > 0) ? [self.game messageAtIndex:index] : @"Flip a card!";
    self.resultLabel.attributedText = [self formatMessage:message];
    self.resultLabel.alpha = (index == 0) ? 1.0f : 0.8f;
    self.resultLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
}

// Returns an attributed string with the given message.
- (NSAttributedString *)formatMessage:(NSString *)message
{
    return [[NSMutableAttributedString alloc] initWithString:message];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgrounds.jpeg"]];
}

@end
