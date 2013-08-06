//
//  PlayingCardView.h
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardView.h"

@interface PlayingCardView : CardView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
