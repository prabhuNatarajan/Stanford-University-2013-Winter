//
//  MatchismoCard.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoCard.h"

@implementation MatchismoCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (MatchismoCard *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end
