//
//  MatchismoCard.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoCard.h"

#define NUMBER_OF_CARDS_TO_MATCH 1

@implementation MatchismoCard

- (NSUInteger )numberOfCardsToMatch
{
    return NUMBER_OF_CARDS_TO_MATCH;
}

// Returns a match score based on whether this card matches the given card
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == [self numberOfCardsToMatch])
    {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[MatchismoCard class]])
        {
            MatchismoCard *card = (MatchismoCard *)otherCard;
            if ([card.contents isEqualToString:self.contents])
            {
                score = 1;
            }
        }
    }
    return score;
}

@end
