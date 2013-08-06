//
//  PlayingCardGameViewController.m
//  GraphicalSet
//
//  Created by Apple on 11/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardGameConstants.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardsCollectionViewCell.h"
#import "GameResult.h"

#define STARTING_CARD_COUNT_MINIMUM 1
#define STARTING_CARD_COUNT 22
#define HAS_UNPLAYABLE_CARDS_REMOVED YES
#define FLIP_ANIMATION_DURATION 1.0
//#define PLAYABLE_CARD_ALPHA 1.0
//#define UNPLAYABLE_CARD_ALPHA 0.3
#define STARTING_CARD_COUNT_INPUT_ALERT_MESSAGE @"Enter the number of cards to start the new game with:"
#define STARTING_CARD_COUNT_INPUT_ALERT_PLACEHOLDER @"Enter a number (%i-%i)"
#define STARTING_CARD_COUNT_INPUT_FIELD_LENGTH 2

@interface PlayingCardGameViewController () <UITextFieldDelegate>

@property (nonatomic, readwrite) NSUInteger startingCardCount;
@property (nonatomic) NSUInteger playingCardStartingCardCount;

@end

@implementation PlayingCardGameViewController

@synthesize startingCardCount  = _startingCardCount;

// Returns the suit of this card.
- (NSUInteger)startingCardCount
{
    if (!_startingCardCount)
    {
        _startingCardCount = STARTING_CARD_COUNT;
    }
    return _startingCardCount;
}

// Sets the suit of this card.
- (void)setStartingCardCount:(NSUInteger)startingCardCount
{
    _startingCardCount = startingCardCount;
}

// Returns the maximum number of cards to start the game with.
+ (NSUInteger)maximumStartingCardCount
{
    return ([PlayingCard validSuits].count * [PlayingCard maxRank]);
}

// Returns whether the game should have its unplayable cards removed.
- (BOOL)hasUnplayableCardsRemoved
{
    return HAS_UNPLAYABLE_CARDS_REMOVED;
}

// Returns a new deck of cards.
- (Deck *)newDeck
{
    return [[PlayingCardDeck alloc] init];
}

// Returns the name of the game.
- (NSString *)gameName
{
    return [GameResult cardMatchGameName];
}

// Renders a card cell.
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated
{
    if ([cell isKindOfClass:[PlayingCardsCollectionViewCell class]])
    {
        PlayingCardView *playingCardView = ((PlayingCardsCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]])
        {
            [UIView transitionWithView:playingCardView
                              duration:FLIP_ANIMATION_DURATION
                               options:(animated) ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionNone
                            animations:^{
                                PlayingCard *playingCard = (PlayingCard *)card;
                                playingCardView.rank = playingCard.rank;
                                playingCardView.suit = playingCard.suit;
                                playingCardView.faceUp = playingCard.isFaceUp;
                                //playingCardView.alpha = (playingCard.isUnplayable) ? UNPLAYABLE_CARD_ALPHA : PLAYABLE_CARD_ALPHA;
                            }
                            completion:NULL];
        }
    }
}

// Returns the restart game confirmation dialog.
- (UIAlertView *)restartGameAlert
{
    UIAlertView *restartGameAlert = [super restartGameAlert];
    if (restartGameAlert)
    {
        // Customize the default alert
        restartGameAlert.message = STARTING_CARD_COUNT_INPUT_ALERT_MESSAGE;
        restartGameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        // Set up the alert's text field
        UITextField *alertTextField = [restartGameAlert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeNumberPad;
        alertTextField.placeholder = [NSString stringWithFormat:STARTING_CARD_COUNT_INPUT_ALERT_PLACEHOLDER, STARTING_CARD_COUNT_MINIMUM, [PlayingCardGameViewController maximumStartingCardCount]];
        alertTextField.text = [NSString stringWithFormat:@"%d", self.startingCardCount];
        alertTextField.delegate = self;
    }
    return restartGameAlert;
}

// Resets the game.
- (void)resetGame
{
    self.startingCardCount = self.playingCardStartingCardCount;
    
    [super resetGame];
}

// (UITextFieldDelegate) Asks the delegate if the specified text should be changed.
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL changeText = NO;
    NSString *combinedInputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSUInteger combinedInputStringLength = [combinedInputString length];
    if (combinedInputStringLength <= STARTING_CARD_COUNT_INPUT_FIELD_LENGTH)
    {
        NSInteger inputStartingCardCount = [combinedInputString integerValue];
        if (combinedInputStringLength)
        {
            // Check whether the number is valid and adjust the number accordingly
            if (inputStartingCardCount < STARTING_CARD_COUNT_MINIMUM)
            {
                inputStartingCardCount = STARTING_CARD_COUNT_MINIMUM;
            }
            else if (inputStartingCardCount > [PlayingCardGameViewController maximumStartingCardCount])
            {
                inputStartingCardCount = [PlayingCardGameViewController maximumStartingCardCount];
            }
            else
            {
                changeText = YES;
            }
        }
        else
        {
            // An empty input field resets to the starting card count default
            inputStartingCardCount = STARTING_CARD_COUNT;
            changeText = YES;
        }
        self.playingCardStartingCardCount = inputStartingCardCount;
        // Update the input field if the number had to be adjusted
        if (!changeText)
        {
            textField.text = [NSString stringWithFormat:@"%d", inputStartingCardCount];
        }
    }
    return changeText;
}

@end
