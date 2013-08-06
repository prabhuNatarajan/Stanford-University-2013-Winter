//
//  setGamesScores.m
//  SET
//
//  Created by Apple on 04/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "setGamesScores.h"

#define CARD_MATCH_GAME_NAME @"Card Match"
#define SET_GAME_NAME @"Set"
#define NAME_KEY @"Name"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_RESULT_KEY @"GameResults"
#define MAXIMUM_GAME_SCORES 05

@interface setGamesScores()

@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSDate *start;
@property (strong, nonatomic, readwrite) NSDate *end;

@end

@implementation setGamesScores

//designated initializer
- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = ([[setGamesScores validGameNames] containsObject:name]) ? name : nil;
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

//default initializer
- (id)init
{
    self =[self initWithName:nil];
    return self;
}

//convinence initializer
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self)
    {
        if ([plist isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _name = resultDictionary[NAME_KEY];
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY]intValue];
            if (!_start || !_end)
            {
                self = nil;
            }
        }
    }
    return self;
}

//sets the score and updates in the end
- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
}

//returns the duration
- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

//updates the user defaults with the data in the game result instance
- (void)synchronize
{
    if (self.name)
    {
        NSString *gameResultsKey = [GAME_RESULT_KEY stringByAppendingString:self.name];
        NSMutableDictionary *mutableGameResultsFromUserDafaults = [[[NSUserDefaults standardUserDefaults]dictionaryForKey:gameResultsKey]mutableCopy];
        if (!mutableGameResultsFromUserDafaults)
        {
            mutableGameResultsFromUserDafaults = [[NSMutableDictionary alloc]init];
        }
        //add/update the result
        mutableGameResultsFromUserDafaults[[self.start description]] = [self asPropertyList];
        //limit the saved result
        NSArray *gameResults = [setGamesScores gameResultsArray:mutableGameResultsFromUserDafaults];
        if ([gameResults count] > MAXIMUM_GAME_SCORES)
        {
            gameResults = [setGamesScores sortedGameResultsArray:gameResults];
            setGamesScores *lastGameResult = (setGamesScores *)[gameResults lastObject];
            [mutableGameResultsFromUserDafaults removeObjectForKey:[lastGameResult.start description]];
        }
        //update the user defaults
        [[NSUserDefaults standardUserDefaults]setObject:mutableGameResultsFromUserDafaults forKey:gameResultsKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

//returns the data in game result as a property list
- (id)asPropertyList
{
    return @{NAME_KEY : self.name, START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score)};
}

//returns the card game name
+ (NSString *)cardMatchingGameName
{
    return CARD_MATCH_GAME_NAME;
}

//returns the set game name
 + (NSString *)setGameName
{
    return SET_GAME_NAME;
}

//returns valid game names
+ (NSArray *)validGameNames
{
    static NSArray *validNames = nil;
    if (!validNames)
    {
        validNames = @[[setGamesScores cardMatchingGameName], [setGamesScores setGameName]];
    }
    return validNames;
}

//returns all game results stored in the user defaults for the given name
+ (NSArray *)resultsForGame:(NSString *)name
{
    NSArray *gameResults = [[NSMutableArray alloc]init];
    if ([[setGamesScores validGameNames] containsObject:name])
    {
        gameResults = [setGamesScores gameResultsArray:[[NSUserDefaults standardUserDefaults]dictionaryForKey:[GAME_RESULT_KEY stringByAppendingString:name]]];
    }
    return [gameResults count] ? [self sortedGameResultsArray:gameResults] : gameResults;
}

//returns the game result in the given dictionary as an array
+ (NSArray *)gameResultsArray:(NSDictionary *)dictionary
{
    NSMutableArray *gameResults = [[NSMutableArray alloc]init];
    for (id plist in [dictionary allValues])
    {
        setGamesScores *gameResult = [[setGamesScores alloc]initFromPropertyList:plist];
        [gameResults addObject:gameResult];
    }
    return gameResults;
}

//returns the game result in the given array as a sorted array
+ (NSArray *)sortedGameResultsArray:(NSArray *)gamrResults
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *scoreDescriptor = [[NSSortDescriptor alloc]initWithKey:@"score" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *durationDescriptor = [[NSSortDescriptor alloc]initWithKey:@"duration" ascending:YES selector:@selector(compare:)];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc]initWithKey:@"end" ascending:YES selector:@selector(compare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, scoreDescriptor, durationDescriptor, dateDescriptor, nil];
    return [gamrResults sortedArrayUsingDescriptors:descriptors];
}

//delete the game results from user defaults
+ (void)resetAllGameResults
{
    for (NSString *gameName in [setGamesScores validGameNames])
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[GAME_RESULT_KEY stringByAppendingString:gameName]];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end