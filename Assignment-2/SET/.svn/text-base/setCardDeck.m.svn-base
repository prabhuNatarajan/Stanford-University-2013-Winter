//
//  setCardDeck.m
//  SET
//
//  Created by Apple on 03/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "setCardDeck.h"
#import "setCard.h"

@implementation setCardDeck

- (id)init
{
    self = [super init];
    if (self)
    {
        for (NSNumber *symbol in [setCard validSymbols])
        {
            for (NSNumber *shadding in [setCard validShadings])
            {
                for (NSNumber *color in [setCard validColors])
                {
                    for (NSUInteger number = [setCard minimumNumber]; number <= [setCard maximumNumber]; number++)
                        {
                            setCard *card = [[setCard alloc]init];
                            card.symbol = [symbol integerValue];
                            card.shading = [shadding integerValue];
                            card.color = [color integerValue];
                            card.number = number;
                            [self addcard:card atTop:YES];
                        }
                }
            }
        }
    }
    return self;
}

@end
