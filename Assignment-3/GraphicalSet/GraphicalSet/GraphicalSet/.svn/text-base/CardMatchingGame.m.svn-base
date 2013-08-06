//
//  CardMatchingGame.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "CardMatchingGame.h"

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define MAX_MESSAGES 100

@interface CardMatchingGame()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < cardCount; i++)
        {
            Card *card = [deck drawRandomCard];
            if (!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
        }
        self.deck = deck;
    }
    return self;
}

// Returns the collection of game cards.
- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
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

// Flip a card, compute a score, and record a play message.
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            // Collect the cards to match
            NSMutableString *cardsString = nil;
            NSMutableArray *cardsToMatch = nil;
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    if (!cardsToMatch)
                    {
                        cardsToMatch = [[NSMutableArray alloc] init];
                        cardsString = [[NSMutableString alloc] init];
                    }
                    [cardsToMatch addObject:otherCard];
                    [cardsString appendFormat:@"%@%@", (cardsString.length) ? @" & " : @"", otherCard.contents];
                    // Stop collecting when we have the necessary number of cards to match
                    if (cardsToMatch.count == ([card numberOfCardsToMatch] - 1))
                    {
                        break;
                    }
                }
            }
            // Check whether we have the necessary number of cards to match
            NSString *message = nil;
            if (cardsToMatch.count == ([card numberOfCardsToMatch] - 1))
            {
                [cardsString appendFormat:@" & %@", card.contents];
                int matchScore = [card match:cardsToMatch];
                if (matchScore)
                {
                    // Make all cards unplayable
                    for (Card *otherCard in cardsToMatch)
                    {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    // Compute the match points and add them to the current score
                    int points = matchScore * MATCH_BONUS;
                    self.score += points;
                    message = [NSString stringWithFormat:@"Matched %@ (+%d pts)", cardsString, points];
                }
                else
                {
                    // Turn down the cards used to match
                    for (Card *otherCard in cardsToMatch)
                    {
                        double delayInSeconds = 0.5;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            otherCard.faceUp = NO;
                            card.faceUp = NO;
                        });
                    }                    
                    // Update the current score with the mismatch penalty
                    self.score -= MISMATCH_PENALTY;
                    message = [NSString stringWithFormat:@"%@ don't match (-%d pts)", cardsString, MISMATCH_PENALTY];
                }
            }
            self.score -= FLIP_COST;
            // Record a play message
            if (!message)
            {
                message = [NSString stringWithFormat:@"Flipped %@", card.contents];
            }
            // Adds a message to the collection of play messages.
            if (message)
            {
                if ([self messageCount] == MAX_MESSAGES)
                {
                    [self.messages removeLastObject];
                }
                [self.messages insertObject:message atIndex:0];
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

// Returns a specific game card.
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self cardCount]) ? self.cards[index] : nil;
}

// Remove the game cards at the given indexes.
- (void)removeCardsAtIndexes:(NSIndexSet *)indexes
{
    if (indexes)
    {
        NSMutableArray *cardsToKeep = [[NSMutableArray alloc] init];
        for (int index = 0; index < [self cardCount]; index++)
        {
            if (![indexes containsIndex:index])
            {
                [cardsToKeep addObject:self.cards[index]];
            }
        }
        self.cards = cardsToKeep;
    }
}

// Returns the number of game cards.
- (NSUInteger)cardCount
{
    return self.cards.count;
}

// Returns whether additional cards can be drawn from the deck.
- (BOOL)hasCardsToDraw
{
    return [self.deck hasCards];
}

// Draw additional cards from the deck, and returns the number of cards drawn.
- (NSUInteger)drawCardsUpToCardCount:(NSUInteger)cardCount
{
    NSUInteger drawnCardCount = 0;
    Card *card = nil;
    while((drawnCardCount < cardCount) && (card = [self.deck drawRandomCard]))
    {
        [self.cards addObject:card];
        drawnCardCount++;
    }
    return drawnCardCount;
}

// Returns the number of recorded play messages.
- (NSUInteger)messageCount
{
    return self.messages.count;
}

// Returns a specific play message.
- (NSString *)messageAtIndex:(NSUInteger)index
{
    return (index < [self messageCount]) ? self.messages[index] : @"";
}

@end
