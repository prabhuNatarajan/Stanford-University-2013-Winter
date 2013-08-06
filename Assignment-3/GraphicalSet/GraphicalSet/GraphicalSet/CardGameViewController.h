//
//  CardGameViewController.h
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (nonatomic, readonly) NSUInteger startingCardCount;
@property (nonatomic, readonly) NSUInteger drawCardCount;
@property (nonatomic, readonly, getter = hasUnplayableCardsRemoved) BOOL unplayableCardsRemoved;
@property (strong, nonatomic) UIAlertView *restartGameAlert;

- (Deck *)newDeck;
- (NSString *)gameName;
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated;
- (void)updateSelectedCardView:(UIView *)view usingCard:(Card *)card asMatchedCard:(BOOL)asMatchedCard;
- (IBAction)restartGame;
- (void)resetGame;

@end
