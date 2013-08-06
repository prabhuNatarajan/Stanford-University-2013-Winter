//
//  setCard.h
//  SET
//
//  Created by Apple on 03/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchismoCard.h"

typedef enum{
    SetCardSymbolDiamond = 1, SetCardSymbolSqiggle = 2, SetCardSymbolOval = 3
}SetCardSymbol;

typedef enum{
    SetCardShadingSolid = 1, SetCardShadingStripped = 2, SetCardShadingOpen = 3
}SetCardShading;

typedef enum{
    SetCardColorRed = 1, SetCardColorGreen = 2, SetCardColorYellow = 3
}SetCardColor;

@interface setCard : MatchismoCard

@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSUInteger )minimumNumber;
+ (NSUInteger )maximumNumber;

@end
