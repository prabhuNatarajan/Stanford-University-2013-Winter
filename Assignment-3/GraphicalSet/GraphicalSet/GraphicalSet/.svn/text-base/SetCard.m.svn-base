//
//  SetCard.m
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SetCard.h"

#define NUMBER_OF_CARDS_TO_MATCH 3
#define MIN_NUMBER 1
#define MAX_NUMBER 3

@implementation SetCard

@synthesize symbol  = _symbol;
@synthesize shading  = _shading;
@synthesize color  = _color;

// Returns a collection of valid symbols.
+ (NSArray *)validSymbols
{
    static NSArray *validSymbols = nil;
    if (!validSymbols)
    {
        validSymbols = @[@(SetCardSymbolDiamond), @(SetCardSymbolSquiggle), @(SetCardSymbolOval)];
    }
    return validSymbols;
}

// Returns a collection of valid shadings.
+ (NSArray *)validShadings
{
    static NSArray *validShadings = nil;
    if (!validShadings)
    {
        validShadings = @[@(SetCardShadingSolid), @(SetCardShadingStriped), @(SetCardShadingOpen)];
    }
    return validShadings;
}

// Returns a collection of valid colors.
+ (NSArray *)validColors
{
    static NSArray *validColors = nil;
    if (!validColors)
    {
        validColors = @[@(SetCardColorRed), @(SetCardColorGreen), @(SetCardColorPurple)];
    }
    return validColors;
}

// Returns the minimum number.
+ (NSUInteger)minNumber
{
    return MIN_NUMBER;
}

// Returns the maximum number.
+ (NSUInteger)maxNumber
{
    return MAX_NUMBER;
}

// Returns the symbol of this card.
- (SetCardSymbol)symbol
{
    return (_symbol) ? _symbol : 0;
}

// Sets the symbol of this card.
- (void)setSymbol:(SetCardSymbol)symbol
{
    if ([[SetCard validSymbols] containsObject:@(symbol)])
    {
        _symbol = symbol;
    }
}

// Returns the shading of this card.
- (SetCardShading)shading
{
    return (_shading) ? _shading : 0;
}

// Sets the shading of this card.
- (void)setShading:(SetCardShading)shading
{
    if ([[SetCard validShadings] containsObject:@(shading)])
    {
        _shading = shading;
    }
}

// Returns the color of this card.
- (SetCardColor)color
{
    return (_color) ? _color : 0;
}

// Sets the color of this card.
- (void)setColor:(SetCardColor)color
{
    if ([[SetCard validColors] containsObject:@(color)])
    {
        _color = color;
    }
}

// Sets the number of this card.
- (void)setNumber:(NSUInteger)number
{
    if (number >= [SetCard minNumber] && number <= [SetCard maxNumber])
    {
        _number = number;
    }
}

// Returns the number of cards needed to match including this one.
- (NSUInteger)numberOfCardsToMatch
{
    return NUMBER_OF_CARDS_TO_MATCH;
}

// Returns a match score based on whether this card makes up a set with the given cards.
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == ([self numberOfCardsToMatch] - 1))
    {
        id firstCard = otherCards[0];
        id secondCard = [otherCards lastObject];
        if ([firstCard isKindOfClass:[SetCard class]] && [secondCard isKindOfClass:[SetCard class]])
        {
            SetCard *firstSetCard = (SetCard *)firstCard;
            SetCard *secondSetCard = (SetCard *)secondCard;
            // Check the equality and uniqueness of all card features
            BOOL sameSymbols = [self areSameFeatures:@(self.symbol) secondNumber:@(firstSetCard.symbol) thirdNumber:@(secondSetCard.symbol)];
            BOOL sameShadings = [self areSameFeatures:@(self.shading) secondNumber:@(firstSetCard.shading) thirdNumber:@(secondSetCard.shading)];
            BOOL sameColors = [self areSameFeatures:@(self.color) secondNumber:@(firstSetCard.color) thirdNumber:@(secondSetCard.color)];
            BOOL sameNumbers = [self areSameFeatures:@(self.number) secondNumber:@(firstSetCard.number) thirdNumber:@(secondSetCard.number)];
            // Check the uniqueness of all card features
            BOOL uniqueSymbols = [self areDistinctFeatures:@(self.symbol) secondNumber:@(firstSetCard.symbol) thirdNumber:@(secondSetCard.symbol)];
            BOOL uniqueShadings = [self areDistinctFeatures:@(self.shading) secondNumber:@(firstSetCard.shading) thirdNumber:@(secondSetCard.shading)];
            BOOL uniqueColors = [self areDistinctFeatures:@(self.color) secondNumber:@(firstSetCard.color) thirdNumber:@(secondSetCard.color)];
            BOOL uniqueNumbers = [self areDistinctFeatures:@(self.number) secondNumber:@(firstSetCard.number) thirdNumber:@(secondSetCard.number)];
            // Determine whether we have a set
            if ((sameSymbols || uniqueSymbols) && (sameShadings || uniqueShadings) && (sameColors || uniqueColors) && (sameNumbers || uniqueNumbers))
            {
                score = 4;
            }
        }
    }
    return score;
}

// Determines whether the given features are all the same.
- (BOOL)areSameFeatures:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber thirdNumber:(NSNumber *)thirdNumber
{
    return ([firstNumber isEqualToNumber:secondNumber] && [secondNumber isEqualToNumber:thirdNumber]);
}

// Determines whether the given features are all distinct.
- (BOOL)areDistinctFeatures:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber thirdNumber:(NSNumber *)thirdNumber
{
    return !([firstNumber isEqualToNumber:secondNumber] || [secondNumber isEqualToNumber:thirdNumber] || [firstNumber isEqualToNumber:thirdNumber]);
}

// Returns a string description of this card.
- (NSString *)contents
{
    return [NSString stringWithFormat:@"[%d,%d,%d,%d]", self.symbol, self.shading, self.color, self.number];
}

@end
