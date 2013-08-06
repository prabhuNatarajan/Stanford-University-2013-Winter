//
//  setCard.m
//  SET
//
//  Created by Apple on 03/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "setCard.h"

#define NUMBER_OF_CARDS_TO_MATCH 2
#define MINIMUM_NUMBER 1
#define MAXIMUM_NUMBER 3

@implementation setCard

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

//return collection of valid symbols
+ (NSArray *)validSymbols
{
    static NSArray *validSymbols = nil;
    if (!validSymbols)
    {
        validSymbols = @[@(SetCardSymbolDiamond), @(SetCardSymbolSqiggle), @(SetCardSymbolOval)];
    }
    return validSymbols;
}

//return collection of valid shadings
+ (NSArray *)validShadings
{
    static NSArray *validShadings = nil;
    if (!validShadings)
    {
        validShadings = @[@(SetCardShadingSolid), @(SetCardShadingStripped), @(SetCardShadingOpen)];
    }
    return validShadings;
}

//return collection of valid colors
+ (NSArray *)validColors
{
    static NSArray *validColors = nil;
    if (!validColors)
    {
        validColors = @[@(SetCardColorRed), @(SetCardColorGreen), @(SetCardColorYellow)];
    }
    return validColors;
}

//return the minimum number
+ (NSUInteger)minimumNumber
{
    return MINIMUM_NUMBER;
}

//return the maximum number
+ (NSUInteger)maximumNumber
{
    return MAXIMUM_NUMBER;
}

//returns the symbol for a card
- (SetCardSymbol)symbol
{
    return (_symbol) ? _symbol : 0;
}

//sets the symbol for a card
- (void)setSymbol:(SetCardSymbol)symbol
{
    if ([[setCard validSymbols]containsObject:@(symbol)])
    {
        _symbol = symbol;
    }
}

//returns the shading for a card
- (SetCardShading)shading
{
    return (_shading) ? _shading : 0;
}

//sets the shading for a card
- (void)setShading:(SetCardShading)shading
{
    if ([[setCard validShadings]containsObject:@(shading)])
    {
        _shading = shading;
    }
}

//return the color for a card
-(SetCardColor)color
{
    return (_color) ? _color : 0;
}

//sets the color for a card
- (void)setColor:(SetCardColor)color
{
    if ([[setCard validColors]containsObject:@(color)])
    {
        _color = color;
    }
}

//sets the number for a card
- (void)setNumber:(NSUInteger)number
{
    if (number >= [setCard minimumNumber] && number <= [setCard maximumNumber])
    {
        _number = number;
    }
}

//returns the number of cards required to match
- (NSUInteger)numberOfCardsToMatch
{
    return NUMBER_OF_CARDS_TO_MATCH;
}

//returns a score on a possible set
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == [self numberOfCardsToMatch])
    {
        id firstCard = otherCards[0];
        id secondCard = [otherCards lastObject];
        if ([firstCard isKindOfClass:[setCard class]] && [secondCard isKindOfClass:[setCard class]])
        {
            setCard *firstSetCard = (setCard *)firstCard;
            setCard *secondSetCard = (setCard *)secondCard;
            //check the equality and uniqueness of all cards
            BOOL sameSymbols = [self areSameFeatures:@(self.symbol) secondNumber:@(firstSetCard.symbol) thirdNumber:@(secondSetCard.symbol)];
            BOOL sameShadings = [self areSameFeatures:@(self.shading) secondNumber:@(firstSetCard.shading) thirdNumber:@(secondSetCard.shading)];
            BOOL smaeColors = [self areSameFeatures:@(self.color) secondNumber:@(firstSetCard.color) thirdNumber:@(secondSetCard.color)];
            BOOL sameNumbers = [self areSameFeatures :@(self.number) secondNumber:@(firstSetCard.number) thirdNumber:@(secondSetCard.number)];
            //check the uniqueness of all cards
            BOOL uniqueSymbols = [self areDistinctFeatures:@(self.symbol) secondNumber:@(firstSetCard.symbol) thirdNumber:@(secondSetCard.symbol)];
            BOOL uniqueShadings = [self areDistinctFeatures:@(self.shading) secondNumber:@(firstSetCard.shading) thirdNumber:@(secondSetCard.shading)];
            BOOL uniqueColors = [self areDistinctFeatures:@(self.color) secondNumber:@(firstSetCard.color) thirdNumber:@(secondSetCard.color)];
            BOOL uniqueNumbers = [self areDistinctFeatures:@(self.number) secondNumber:@(firstSetCard.number) thirdNumber:@(secondSetCard.number)];
            //determine wheather we have a set
            if ((sameSymbols || uniqueSymbols) && (sameShadings || uniqueShadings) && (smaeColors || uniqueColors) && (sameNumbers || uniqueNumbers))
            {
                score = 4;
            }
        }
    }
    return score;
}

//determine wheather the given features are all same
- (BOOL)areSameFeatures:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber thirdNumber:(NSNumber *)thirdNumber
{
    return ([firstNumber isEqualToNumber:secondNumber] && [secondNumber isEqualToNumber:thirdNumber]);
}

//determine wheather the given features are all distinct
- (BOOL)areDistinctFeatures:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber thirdNumber:(NSNumber *)thirdNumber
{
    return !([firstNumber isEqualToNumber:secondNumber] || [secondNumber isEqualToNumber:thirdNumber] || [firstNumber isEqualToNumber:thirdNumber]);
}

//returns a string description of selected cards
- (NSString *)contents
{
    return [NSString stringWithFormat:@"[%d,%d,%d,%d]",self.symbol,self.shading,self.color,self.number];
}

@end
