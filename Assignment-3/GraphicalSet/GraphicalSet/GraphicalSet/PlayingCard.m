//
//  PlayingCard.m
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit  = _suit;

// Returns a match score based on whether or how this card matches the given card.
- (int)match:(NSArray *)otherCards
{
    int score = 0;    
    if (otherCards.count == ([self numberOfCardsToMatch] - 1))
    {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit])
            {
                score = 1;
            }
            else if (otherPlayingCard.rank == self.rank)
            {
                score = 4;
            }
        }
    }
    return score;
}

// Returns a string description of this card.
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// Returns a collection of valid suits.
+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits)
    {
        validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    }
    return validSuits;
}

// Returns a collection of all ranks.
+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings)
    {
        rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    return rankStrings;
}

// Returns the maximum rank.
+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

// Returns the suit of this card.
- (NSString *)suit
{
    return (_suit) ? _suit : @"?";
}

// Sets the suit of this card.
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

// Sets the rank of this card.
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
