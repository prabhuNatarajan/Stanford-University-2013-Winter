//
//  setGamesScores.h
//  SET
//
//  Created by Apple on 04/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface setGamesScores : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSDate *start;
@property (strong, nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) int score;

- (id)initWithName:(NSString *)name;
- (void)synchronize;
+ (NSString *)cardMatchingGameName;
+ (NSString *)setGameName;
+ (NSArray *)resultsForGame:(NSString *)name;
+ (void)resetAllGameResults;

@end