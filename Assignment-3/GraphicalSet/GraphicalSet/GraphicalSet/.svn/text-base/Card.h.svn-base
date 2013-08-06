//
//  Card.h
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
- (NSUInteger)numberOfCardsToMatch;
- (int)match:(NSArray *)otherCards;

@end