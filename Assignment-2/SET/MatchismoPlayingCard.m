//
//  MatchismoPlayingCard.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoPlayingCard.h"

@implementation MatchismoPlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (id otherCard in otherCards)
    {
        if ([otherCard isKindOfClass:[MatchismoPlayingCard class]])
        {
            MatchismoPlayingCard *otherPlayingCard = (MatchismoPlayingCard *) otherCard;
            score += [self matchPlayingCard:otherPlayingCard];
        }
    }
    return score;
}

- (int)matchPlayingCard:(MatchismoPlayingCard *)otherPlayingCard
{
    int score = 0;
    if ([otherPlayingCard.suit isEqualToString:self.suit])
    {
        score = 1;
    }
    else if (otherPlayingCard.rank == self.rank)
    {
        score = 4;
    }
    return score;
}


+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (NSString *)contents
{
    NSArray *rankStrings=[MatchismoPlayingCard rankStrings];
    return [rankStrings [self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[MatchismoPlayingCard validSuits]containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [MatchismoPlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
