//
//  MatchismoPlayingCardDeck.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoPlayingCardDeck.h"
#import "MatchismoPlayingCard.h"

@implementation MatchismoPlayingCardDeck

- (id)init
{
    self = [super init];
    if (self)
    {
        for (NSString *suit in [MatchismoPlayingCard validSuits])
        {
            for (NSUInteger rank = 1; rank <= [MatchismoPlayingCard maxRank]; rank++)
            {
                MatchismoPlayingCard *card = [[MatchismoPlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addcard:card atTop:YES];
            }
        }
    }
    return self;
}

@end
