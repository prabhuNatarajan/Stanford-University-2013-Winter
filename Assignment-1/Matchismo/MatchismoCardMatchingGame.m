//
//  MatchismoCardMatchingGame.m
//  Matchismo
//
//  Created by Apple on 24/06/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MatchismoCardMatchingGame.h"

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MINIMUM_MATCH_COUNT 2
#define MAXIMUM_MATCH_COUNT 3
#define MISMATCH_PENALITY 2
#define MAXIMUM_MESSAGES 52

@interface MatchismoCardMatchingGame()

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;

@end

@implementation MatchismoCardMatchingGame

@synthesize matchCount = _matchCount;

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger )cardCount usingDeck:(MatchismoDeck *)deck matchCount:(NSUInteger )matchcount
{
    self = [super init];
    if (self)
    {
        for (int i=0; i<cardCount; i++)
        {
            MatchismoCard *card = [deck drawRandomCard];
            if (!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
        }
        self.matchCount = matchcount;
    }
    return self;
}

// Returns the collection of play messages.
- (NSMutableArray *)messages
{
    if (!_messages)
    {
        _messages = [[NSMutableArray alloc] init];
    }
    return _messages;
}

//return no of game cards to use
- (NSUInteger )matchCount
{
    if (!_matchCount)
    {
        _matchCount = MINIMUM_MATCH_COUNT;
    }
    return _matchCount;
}

// Sets the number of game card matches to use.
- (void)setMatchCount:(NSUInteger )matchCount
{
    _matchCount = (matchCount < MINIMUM_MATCH_COUNT) ? MINIMUM_MATCH_COUNT : (matchCount > MAXIMUM_MATCH_COUNT) ? MAXIMUM_MATCH_COUNT : matchCount;
}

- (MatchismoCard *)cardAtindex:(NSUInteger )index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtindex:(NSUInteger )index
{
    MatchismoCard *card = [self cardAtIndex:index];
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            // Collect the cards to match
            NSMutableString *cardsString = nil;
            NSMutableArray *cardsToMatch = nil;
            for (MatchismoCard *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    // Include the card we are flipping in the collection of cards to match
                    if (!cardsToMatch)
                    {
                        cardsToMatch = [[NSMutableArray alloc] init];
                        [cardsToMatch addObject:card];
                        cardsString = [NSMutableString stringWithFormat: @"%@", card.contents];
                    }
                    [cardsToMatch addObject:otherCard];
                    [cardsString appendFormat:@" %@", otherCard.contents];
                    // Stop collecting when we have the necessary number of cards to match
                    if (cardsToMatch.count == self.matchCount)
                    {
                        break;
                    }
                }
            }
            // Check whether we have all the necessary cards
            NSString *message = nil;
            if (cardsToMatch.count == self.matchCount)
            {
                // Compute the total match score based on the cummulative score of matching pairs
                int matchScore = 0;
                for (int i = 0; i < cardsToMatch.count; i++)
                {
                    NSRange range;
                    range.location = i + 1;
                    range.length = cardsToMatch.count - (i + 1);
                    matchScore += [[cardsToMatch objectAtIndex:i] match:[cardsToMatch subarrayWithRange:range]];
                }
                // Check whether there were any matches
                if (matchScore)
                {
                    // Cards can only be used once if they are part of a group with at least a partial match
                    for (MatchismoCard *otherCard in cardsToMatch)
                    {
                        otherCard.unplayable = YES;
                    }
                    // Compute the match points and add them to the current score
                    int points = matchScore * MATCH_BONUS;
                    self.score += points;
                    message = [NSString stringWithFormat:@"Match found in %@ (+%d pts)", cardsString, points];
                } else
                {
                    // Turn down all cards if there were no matches
                    for (MatchismoCard *otherCard in cardsToMatch)
                    {
                        otherCard.faceUp = NO;
                    }
                    // Update the current score with the necessary penalty
                    self.score -= MISMATCH_PENALITY;
                    message = [NSString stringWithFormat:@"No match found in %@ (-%d pts)", cardsString, MISMATCH_PENALITY];
                }
            }            
            // Update the current score with the cost of flipping the card too
            self.score -= FLIP_COST;
            // Record a play message
            if (!message)
            {
                message = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            if (message)
            {
                if (self.messages.count == MAXIMUM_MESSAGES)
                {
                    [self.messages removeLastObject];
                }
                [self.messages insertObject:message atIndex:0];
            }
        }
        // Flip the card
        card.faceUp = !card.isFaceUp;
    }
}

// Returns the number of recorded play messages.
- (NSUInteger )messageCount
{
    return self.messages.count;
}

// Returns a specific game card.
- (MatchismoCard *)cardAtIndex:(NSUInteger )index
{
 return (index < self.cards.count) ? self.cards[index] : nil;
}

// Returns a specific play message.
- (NSString *)messageAtIndex:(NSUInteger )index
{
    return (index < self.messages.count) ? self.messages[index] : @"";
}

@end