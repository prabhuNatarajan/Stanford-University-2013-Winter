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
#define MISMATCH_PENALITY 2
#define MAXIMUM_MESSAGES 53

@interface MatchismoCardMatchingGame()

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;

@end

@implementation MatchismoCardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger )cardCount usingDeck:(MatchismoDeck *)deck
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
    }
    return self;
}

//Returns the collection of play messages.
- (NSMutableArray *)messages
{
    if (!_messages)
    {
        _messages = [[NSMutableArray alloc] init];
    }
    return _messages;
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
            //Collect the cards to match
            NSMutableString *cardsString = nil;
            NSMutableArray *cardsToMatch = nil;
            for (MatchismoCard *otherCard in self.cards)
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
                    //Stop collecting when we have the necessary number of cards to match
                    if (cardsToMatch.count == [card numberOfCardsToMatch])
                    {
                        break;
                    }
                }
            }
            //Check whether we have the necessary number of cards to match
            NSString *message = nil;
            if (cardsToMatch.count == [card numberOfCardsToMatch])
            {
                [cardsString appendFormat:@" & %@", card.contents];
                int matchScore = [card match:cardsToMatch];
                if (matchScore)
                {
                    //Make all cards unplayable
                    for (MatchismoCard *otherCard in cardsToMatch)
                    {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    //Compute the match points and add them to the current score
                    int points = matchScore * MATCH_BONUS;
                    self.score += points;
                    message = [NSString stringWithFormat:@"Matched %@ (+%d pts)", cardsString, points];
                }
                else
                {
                    //Turn down the cards used to match
                    for (MatchismoCard *otherCard in cardsToMatch)
                    {
                        double delayInSeconds = 0.5;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                         otherCard.faceUp = NO;
                         card.faceUp = NO;
                        });
                    }
                    //Update the current score with the mismatch penalty
                    self.score -= MISMATCH_PENALITY;
                    message = [NSString stringWithFormat:@"%@ don't match (-%d pts)", cardsString, MISMATCH_PENALITY];
                }
            }            
            self.score -= FLIP_COST;
            //Record a play message
            if (!message)
            {
                message = [NSString stringWithFormat:@"Flipped %@", card.contents];
            }
            if (message)
            {
                if ([self messageCount] == MAXIMUM_MESSAGES)
                {
                    [self.messages removeLastObject];
                }
                [self.messages insertObject:message atIndex:0];
            }
        }
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