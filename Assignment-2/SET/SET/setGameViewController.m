//
//  setGameViewController.m
//  SET
//
//  Created by Apple on 04/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "setGameViewController.h"
#import "SetCardDeck.h"
#import "MatchismoCardMatchingGame.h"
#import "SetCard.h"
#import "setGamesScores.h"

@implementation setGameViewController

//returns name of the game
- (NSString *)gameName
{
    return [setGamesScores setGameName];
}

//returns a new deck of cards
- (MatchismoDeck *)newDeck
{
    return [[setCardDeck alloc]init];
}

//Render a card button.
- (void)renderCardButton:(UIButton *)cardButton card:(MatchismoCard *)card
{
    cardButton.backgroundColor = [UIColor whiteColor];
    cardButton.layer.borderColor = [UIColor grayColor].CGColor;
    cardButton.layer.borderWidth = 0.5f;
    cardButton.layer.cornerRadius = 10.0f;
    [cardButton setAttributedTitle:[self convertCardContentsToSymbols:card.contents] forState:UIControlStateNormal];
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = (card.isUnplayable) ? 0.0f : 1.0f;
    [cardButton setBackgroundColor:(cardButton.selected) ? [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f]: [UIColor whiteColor]];
}

//Returns an attributed string with the given message.
- (NSAttributedString *)formatMessage:(NSString *)message
{
    NSMutableAttributedString *formattedMessage = [[NSMutableAttributedString alloc] initWithString:message];
    // Look for substrings formatted as SetCard contents strings
    NSError *error = NULL;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\[[0-9]+(,[0-9]+)*\\]" options:0 error:&error];
    if (!error)
    {
        NSArray *matches = [regularExpression matchesInString:message options:0 range:NSMakeRange(0, [message length])];
        for (NSTextCheckingResult *match in [matches reverseObjectEnumerator])
        {
            // Convert the card contents strings to symbols
            NSRange matchRange = [match range];
            [formattedMessage replaceCharactersInRange:matchRange withAttributedString:[self convertCardContentsToSymbols:[message substringWithRange:matchRange]]];
        }
    }
    return formattedMessage;
}

// Convert a card contents string to an attributed string of symbols.
- (NSAttributedString *)convertCardContentsToSymbols:(NSString *)contents
{
    SetCardSymbol symbol = 0;
    SetCardShading shading = 0;
    SetCardColor color = 0;
    NSUInteger number = 0;
    NSError *error = NULL;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:0 error:&error];
    if (!error)
    {
        NSArray *matches = [regularExpression matchesInString:contents options:0 range:NSMakeRange(0, [contents length])];
        if (matches.count == 4)
        {
            symbol = [[contents substringWithRange:[matches[0] range]] integerValue];
            shading = [[contents substringWithRange:[matches[1] range]] integerValue];
            color = [[contents substringWithRange:[matches[2] range]] integerValue];
            number = [[contents substringWithRange:[matches[3] range]] integerValue];
        }
    }
    //Get the string of symbols
    NSString *symbolsString = [self getStringOfSymbols:symbol shading:shading number:number];
    NSMutableAttributedString *attributedSymbolString = [[NSMutableAttributedString alloc] initWithString:(symbolsString) ? symbolsString : @"?"];
    if (symbolsString && [[setCard validColors] containsObject:@(color)])
    {
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        //Set the color and alpha
        NSArray *colors = @[[NSNull null], [UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
        UIColor *symbolColor = colors[color];
        [attributes setObject:!(shading == SetCardShadingStripped) ? symbolColor : [symbolColor colorWithAlphaComponent:0.3f] forKey:NSForegroundColorAttributeName];
        [attributes setObject:@-4 forKey:NSStrokeWidthAttributeName];
        [attributes setObject:symbolColor forKey:NSStrokeColorAttributeName];
        [attributedSymbolString addAttributes:attributes range:NSMakeRange(0, [attributedSymbolString length])];
    }
    return attributedSymbolString;
}

//Creates a string of symbols based on the given cards
- (NSString *)getStringOfSymbols:(SetCardSymbol)symbol shading:(SetCardShading)shading number:(NSUInteger)number
{
    NSMutableArray *symbols = nil;
    if ([[setCard validSymbols] containsObject:@(symbol)] && [[setCard validShadings] containsObject:@(shading)] && (number >= [setCard minimumNumber] && number <= [setCard maximumNumber]))
    {
        NSArray *symbolStrings = (shading == SetCardShadingOpen) ?  @[[NSNull null], @"△", @"○", @"□"] : @[[NSNull null], @"▲", @"●", @"■"];
        for (NSUInteger count = 0; count < number; count++)
        {
            if (!symbols)
            {
                symbols = [[NSMutableArray alloc] init];
            }
            [symbols addObject:symbolStrings[symbol]];
        }
    }
    return (symbols) ? [symbols componentsJoinedByString:@""] : nil;
}

@end