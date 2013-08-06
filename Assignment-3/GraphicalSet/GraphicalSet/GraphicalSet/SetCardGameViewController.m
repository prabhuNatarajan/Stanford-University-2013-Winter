//
//  SetCardGameViewController.m
//  GraphicalSet
//
//  Created by Apple on 11/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SetCardGameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"
#import "GameResult.h"

#define STARTING_CARD_COUNT 12
#define DRAW_CARD_COUNT 3
#define HAS_UNPLAYABLE_CARDS_REMOVED YES
#define ANIMATION_DURATION 1.0
#define PLAYABLE_CARD_ALPHA 1.0
#define UNPLAYABLE_CARD_ALPHA 0.3
#define SELECTED_CARD_ALPHA 1.0

@implementation SetCardGameViewController

// Returns the number of cards to start the game with.
- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

// Returns the number of cards to draw.
- (NSUInteger)drawCardCount
{
    return DRAW_CARD_COUNT;
}

// Returns whether the game should have its unplayable cards removed.
- (BOOL)hasUnplayableCardsRemoved
{
    return HAS_UNPLAYABLE_CARDS_REMOVED;
}

// Returns a new deck of cards.
- (Deck *)newDeck
{
    return [[SetCardDeck alloc] init];
}

// Returns the name of the game.
- (NSString *)gameName
{
    return [GameResult setGameName];
}

// Renders a card cell.
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]])
    {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]])
        {
            [UIView transitionWithView:setCardView
                              duration:ANIMATION_DURATION
                               options:(animated) ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionNone
                            animations:^{
                                SetCard *setCard = (SetCard *)card;
                                setCardView.symbol = setCard.symbol;
                                setCardView.shading = setCard.shading;
                                setCardView.color = setCard.color;
                                setCardView.number = setCard.number;
                                setCardView.faceUp = setCard.isFaceUp;
                                setCardView.alpha = SELECTED_CARD_ALPHA;
                            }
                            completion:NULL];
        }
    }
}

// Renders a selected card view.
- (void)updateSelectedCardView:(UIView *)view usingCard:(Card *)card asMatchedCard:(BOOL)asMatchedCard
{
    if ([view isKindOfClass:[SetCardView class]])
    {
        SetCardView *setCardView = (SetCardView *)view;
        [UIView transitionWithView:setCardView duration:ANIMATION_DURATION
                           options:(asMatchedCard) ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionNone
                        animations:^{
                            if (card)
                            {
                                SetCard *setCard = (SetCard *)card;
                                setCardView.symbol = setCard.symbol;
                                setCardView.shading = setCard.shading;
                                setCardView.color = setCard.color;
                                setCardView.number = setCard.number;
                                setCardView.faceUp = setCard.isFaceUp;
                                setCardView.unplayable = setCard.isUnplayable;
                                setCardView.matched = asMatchedCard;
                            }
                            else
                            {
                                setCardView.symbol = 0;
                                setCardView.shading = 0;
                                setCardView.color = 0;
                                setCardView.number = 0;
                                setCardView.faceUp = NO;
                                setCardView.unplayable = NO;
                                setCardView.matched = NO;
                            }
                            setCardView.alpha = SELECTED_CARD_ALPHA;
                        }
                        completion:NULL];
    }
}

@end
