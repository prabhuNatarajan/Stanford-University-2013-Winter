//
//  SetCard.h
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardGameConstants.h"
#import "Card.h"

@interface SetCard : Card

@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (nonatomic) NSUInteger number;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSUInteger)minNumber;
+ (NSUInteger)maxNumber;

@end
