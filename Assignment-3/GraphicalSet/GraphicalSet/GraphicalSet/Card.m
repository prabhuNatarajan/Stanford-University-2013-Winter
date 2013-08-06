//
//  Card.m
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "Card.h"

#define NUMBER_OF_CARDS_TO_MATCH 2

@implementation Card

// Returns the number of cards needed to match including this one.
- (NSUInteger)numberOfCardsToMatch
{
    return NUMBER_OF_CARDS_TO_MATCH;
}

// Returns a match score based on whether this card matches the given card.
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == ([self numberOfCardsToMatch] - 1))
    {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[Card class]])
        {
            Card *card = (Card *) otherCard;
            if ([card.contents isEqualToString:self.contents])
            {
                score = 1;
            }
        }
    }
    return score;
}

@end
