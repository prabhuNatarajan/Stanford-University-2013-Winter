//
//  CardMatchingGame.h
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : Deck

@property (nonatomic, readonly) int score;

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)removeCardsAtIndexes:(NSIndexSet *)indexes;
- (NSUInteger)cardCount;
- (BOOL)hasCardsToDraw;
- (NSUInteger)drawCardsUpToCardCount:(NSUInteger)cardCount;
- (NSUInteger)messageCount;
- (NSString *)messageAtIndex:(NSUInteger)index;

@end
