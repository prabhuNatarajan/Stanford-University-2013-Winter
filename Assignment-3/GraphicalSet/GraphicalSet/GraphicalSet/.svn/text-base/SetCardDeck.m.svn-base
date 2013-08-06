//
//  SetCardDeck.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

// Default initializer
- (id)init
{
    self = [super init];
    if (self)
    {
        for (NSNumber *symbol in [SetCard validSymbols])
        {
            for (NSNumber *shading in [SetCard validShadings])
            {
                for (NSNumber *color in [SetCard validColors])
                {
                    for (NSUInteger number = [SetCard minNumber]; number <= [SetCard maxNumber]; number++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = [symbol integerValue];
                        card.shading = [shading integerValue];
                        card.color = [color integerValue];
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end