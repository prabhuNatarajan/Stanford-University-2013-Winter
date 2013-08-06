//
//  MatchismoCardMatchingGame.h
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchismoDeck.h"

@interface MatchismoCardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic) NSUInteger matchCount;

- (id)initWithCardCount:(NSUInteger )cardCount usingDeck:(MatchismoDeck *)deck matchCount:(NSUInteger )matchcount;
- (void)flipCardAtindex:(NSUInteger )index;
- (MatchismoCard *)cardAtindex:(NSUInteger )index;
- (NSUInteger )messageCount;
- (NSString *)messageAtIndex:(NSUInteger )index;

@end
