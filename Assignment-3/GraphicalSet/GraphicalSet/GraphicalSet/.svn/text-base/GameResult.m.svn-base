//
//  GameResult.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "GameResult.h"

#define CARD_MATCH_GAME_NAME @"Card Match"
#define SET_GAME_NAME @"Set"
#define NAME_KEY @"Name"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_RESULTS_KEY @"GameResults_"
#define MAX_GAME_SCORES 05

@interface GameResult()

@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSDate *start;
@property (strong, nonatomic, readwrite) NSDate *end;

@end

@implementation GameResult

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = ([[GameResult validGameNames] containsObject:name]) ? name : nil;
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (id)init
{
    self = [self initWithName:nil];
    return self;
}

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
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end)
            {
                self = nil;
            }
        }
    }
    return self;
}

// Sets the score and updates the end time.
- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
}

// Returns the duration between the time the score was last updated (i.e. end time) and the time this game result instance was created (i.e. start time).
- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

// Updates the user defaults with the data in this game result instance.
- (void)synchronize
{
    if (self.name)
    {
        // Get the results for the given game name
        NSString *gameResultsKey = [GAME_RESULTS_KEY stringByAppendingString:self.name];
        NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:gameResultsKey] mutableCopy];
        if (!mutableGameResultsFromUserDefaults)
        {
            mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
        }
        // Add/update this result
        mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
        // Limit the number of saved results
        NSArray *gameResults = [GameResult gameResultArray:mutableGameResultsFromUserDefaults];
        if ([gameResults count] > MAX_GAME_SCORES)
        {
            // Sort the results and drop the worst one to make space for the new, better result
            gameResults = [GameResult sortedGameResultArray:gameResults];
            GameResult *lastGameResult = (GameResult *)[gameResults lastObject];
            [mutableGameResultsFromUserDefaults removeObjectForKey:[lastGameResult.start description]];
        }
        // Update the user defaults
        [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:gameResultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// Returns the data in this game result as a property list.
- (id)asPropertyList
{
    return @{NAME_KEY : self.name, START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score)};
}

// Returns the Card Match game name.
+ (NSString *)cardMatchGameName
{
    return CARD_MATCH_GAME_NAME;
}

// Returns the Set game name.
+ (NSString *)setGameName
{
    return SET_GAME_NAME;
}

// Returns a collection of valid game names.
+ (NSArray *)validGameNames
{
    static NSArray *validNames = nil;
    
    if (!validNames)
    {
        validNames = @[[GameResult cardMatchGameName], [GameResult setGameName]];
    }
    return validNames;
}

// Returns a collection of all game results stored in the user defaults for the given game name.
+ (NSArray *)resultsForGame:(NSString *)name
{
    NSArray *gameResults = [[NSMutableArray alloc] init];
    
    if ([[GameResult validGameNames] containsObject:name])
    {
        gameResults = [GameResult gameResultArray:[[NSUserDefaults standardUserDefaults] dictionaryForKey:[GAME_RESULTS_KEY stringByAppendingString:name]]];
    }
    return [gameResults count] ? [self sortedGameResultArray:gameResults] : gameResults;
}

// Returns the game results contained in the given dictionary as an array.
+ (NSArray *)gameResultArray:(NSDictionary *)dictionary
{
    NSMutableArray *gameResults = [[NSMutableArray alloc] init];
    for (id plist in [dictionary allValues])
    {
        GameResult *gameResult = [[GameResult alloc] initFromPropertyList:plist];
        [gameResults addObject:gameResult];
    }
    return gameResults;
}

// Returns the game results contained in the given array as a sorted array.
+ (NSArray *)sortedGameResultArray:(NSArray *)gameResults
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *scoreDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *durationDescriptor = [[NSSortDescriptor alloc] initWithKey:@"duration" ascending:YES selector:@selector(compare:)];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"end" ascending:YES selector:@selector(compare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, scoreDescriptor, durationDescriptor, dateDescriptor, nil];
    return [gameResults sortedArrayUsingDescriptors:descriptors];
}

// Deletes all game results from the user defaults.
+ (void)resetAllGameResults
{
    for (NSString *gameName in [GameResult validGameNames])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[GAME_RESULTS_KEY stringByAppendingString:gameName]];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
