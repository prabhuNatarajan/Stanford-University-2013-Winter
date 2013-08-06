//
//  MatchismoDeck.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoDeck.h"

@interface MatchismoDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation MatchismoDeck

- (NSMutableArray *)cards
{
    if (!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (void)addcard:(MatchismoCard *)card atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

- (MatchismoCard *)drawRandomCard
{
    MatchismoCard *randomCard = nil;
    if (self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
