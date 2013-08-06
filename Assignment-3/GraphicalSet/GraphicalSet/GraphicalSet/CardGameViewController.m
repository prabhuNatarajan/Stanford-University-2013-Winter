//
//  CardGameViewController.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "CardGameConstants.h"

#define ENABLED_DEAL_CARDS_BUTTON_ALPHA 1.0
#define DISABLED_DEAL_CARDS_BUTTON_ALPHA 0.3
#define MESSAGE_LABEL_FONT_SIZE 13.0
#define NEW_MESSAGE_LABEL_ALPHA 1.0
#define OLD_MESSAGE_LABEL_ALPHA 0.5
#define RESTART_GAME_ALERT_TITLE @"Confirm Restart"
#define RESTART_GAME_ALERT_MESSAGE @"Are you sure you want to restart the game?"

@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealCardsButton;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *selectedCardViews;
@property (nonatomic) uint flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) NSArray *selectedCards;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Order the selected card views based on their tags
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.selectedCardViews = [self.selectedCardViews sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
}

// Returns the restart game confirmation dialog.
- (UIAlertView *)restartGameAlert
{
    if (!_restartGameAlert)
    {
        _restartGameAlert = [[UIAlertView alloc] initWithTitle:RESTART_GAME_ALERT_TITLE message:RESTART_GAME_ALERT_MESSAGE delegate:self cancelButtonTitle:CANCEL_BUTTON_TITLE otherButtonTitles:OK_BUTTON_TITLE, nil];
    }
    return _restartGameAlert;
}

// UICollectionViewDataSource: Asks the data source for the number of items in the specified section.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.game cardCount];
}

// UICollectionViewDataSource: Asks the data source for the cell that corresponds to the specified item in the collection view.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animated:NO];
    return cell;
}

// Returns a game instance.
- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self newDeck]];
    }
    return _game;
}

// Returns a new deck of cards.
- (Deck *)newDeck
{
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Method not implemented" userInfo:nil];
}

// Returns a game result instance.
- (NSArray *)selectedCards
{
    if (!_selectedCards)
    {
        _selectedCards = [[NSArray alloc] init];
    }
    return _selectedCards;
}

// Returns a game result instance.
- (GameResult *)gameResult
{
    if (!_gameResult)
    {
        _gameResult = [[GameResult alloc] initWithName:[self gameName]];
    }
    return _gameResult;
}

// Returns the name of the game.
- (NSString *)gameName
{
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Method not implemented" userInfo:nil];
}

// Renders the complete user interface.
- (void)updateUI
{
    [self updateUI:-1];
}

// Renders the complete user interface.
- (void)updateUI:(NSInteger)flippedCardIndex
{
    // Update the card cells
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animated:(indexPath.item == flippedCardIndex && !card.isUnplayable)];
    }
    // Update the selected card views
    if (self.selectedCardViews.count)
    {
        for (int index = 0; index < self.selectedCardViews.count; index++)
        {
            [self updateSelectedCardView:self.selectedCardViews[index] usingCard:(index < self.selectedCards.count) ? self.selectedCards[index] : nil asMatchedCard:self.selectedCards.count == self.selectedCardViews.count];
        }
    }
    // Check whether unplayable game cards need to be removed
    if ([self hasUnplayableCardsRemoved])
    {
        // Store both the game card indexes and the index path of the cells of all unplayable cards
        NSMutableIndexSet *indexesOfUnplayableCards = [[NSMutableIndexSet alloc] init];
        NSMutableArray *indexPathsOfUnplayableCardCells = [[NSMutableArray alloc] init];
        for (int index = 0; index < [self.game cardCount]; index++)
        {
            Card *card = [self.game cardAtIndex:index];
            if (card.isUnplayable)
            {
                [indexesOfUnplayableCards addIndex:index];
                [indexPathsOfUnplayableCardCells addObject:[NSIndexPath indexPathForRow:index inSection:0]];
            }
        }
        // Remove all unplayable cards and their corresponding cells
        [self.cardCollectionView performBatchUpdates:^{
            [self.game removeCardsAtIndexes:indexesOfUnplayableCards];
            [self.cardCollectionView deleteItemsAtIndexPaths:indexPathsOfUnplayableCardCells];
        } completion:nil];
    }
    // Update the score label
    self.scoreLabel.text = [NSString stringWithFormat:@"%@%03d", (self.game.score < 0) ? @"-" : @"", abs(self.game.score)];
    // Display the last game message
    [self displayMessage:0];
}

// Renders a card cell.
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated
{
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Method not implemented" userInfo:nil];
}

// Renders a selected card view.
- (void)updateSelectedCardView:(UIView *)view usingCard:(Card *)card asMatchedCard:(BOOL)asMatchedCard
{
    @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"Method not implemented" userInfo:nil];
}

// Flips a game card.
- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath)
    {
        [self.game flipCardAtIndex:indexPath.item];
        self.selectedCards = [self selectedCardsWithCard:[self.game cardAtIndex:indexPath.item]];
        self.gameResult.score = self.game.score;
        self.flipCount++;
        [self updateUI:indexPath.item];
    }
}

// Returns a new collection of selected cards made up of the currently selected cards and the given card.
- (NSArray *)selectedCardsWithCard:(Card *)card
{
    NSMutableArray *selectedCardsToKeep = (self.selectedCards.count < self.selectedCardViews.count) ? [NSMutableArray arrayWithArray:self.selectedCards] : [[NSMutableArray alloc] init];
    if (card)
    {
        if (self.selectedCards.count >= self.selectedCardViews.count)
        {
            for (int index = 0; index < self.selectedCards.count; index++)
            {
                Card *selectedCard = self.selectedCards[index];
                if (selectedCard.isFaceUp && !selectedCard.isUnplayable)
                {
                    [selectedCardsToKeep addObject:selectedCard];
                }
            }
        }
        
        [selectedCardsToKeep removeObject:card];
        if (card.isFaceUp)
        {
            [selectedCardsToKeep addObject:card];
        }
    }
    return selectedCardsToKeep;
}

// Shows a game message string.
- (void)displayMessage:(NSUInteger)index
{
    NSString *message = (self.game.messageCount > 0) ? [self.game messageAtIndex:index] : @"Flip a card!";
    self.messageLabel.attributedText = [self formatMessage:message];
    self.messageLabel.alpha = (index == 0) ? NEW_MESSAGE_LABEL_ALPHA : OLD_MESSAGE_LABEL_ALPHA;
    self.messageLabel.font = [UIFont fontWithName:@"Helvetica" size:MESSAGE_LABEL_FONT_SIZE];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
}

// Returns an attributed string with the given message.
- (NSAttributedString *)formatMessage:(NSString *)message
{
    return [[NSMutableAttributedString alloc] initWithString:message];
}

// Deal game cards.
- (IBAction)dealCards
{
    NSUInteger cardCount = [self.game cardCount];
    NSUInteger drawnCardCount = [self.game drawCardsUpToCardCount:self.drawCardCount];
    if (drawnCardCount)
    {
        // Add the necessary cell index paths
        NSMutableArray *arrayWithIndexPaths = [[NSMutableArray alloc] init];
        [self.cardCollectionView performBatchUpdates:^{
            for (int row = cardCount; row < cardCount + drawnCardCount; row++)
            {
                [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:row inSection:0]];
            }
            [self.cardCollectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
        } completion:^(BOOL finished) {
            // Scroll to the last cell added
            [self.cardCollectionView scrollToItemAtIndexPath:[arrayWithIndexPaths lastObject] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }];
    }
    // Disable the deal cards button if no more games cards can be drawn
    if (![self.game hasCardsToDraw])
    {
        [self.dealCardsButton setEnabled:NO];
        self.dealCardsButton.alpha = DISABLED_DEAL_CARDS_BUTTON_ALPHA;
    }
}

// Restarts the game
- (IBAction)restartGame
{
    [self.restartGameAlert show];
}

// (UIAlertViewDelegate) Sent to the delegate when the user clicks a button on an alert view.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case OK_BUTTON_INDEX:
        {
            [self resetGame];
            
            break;
        }
        case CANCEL_BUTTON_INDEX:
        default:
        {
            // Nothing to do
        }
    }
}

// Resets the game.
- (void)resetGame
{
    // Save the game results
    if(self.flipCount)
    {
        [self.gameResult synchronize];
    }
    // Reset the game
    self.selectedCards = nil;
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    // Enable the deal cards button
    [self.dealCardsButton setEnabled:YES];
    self.dealCardsButton.alpha = ENABLED_DEAL_CARDS_BUTTON_ALPHA;
    // Ask the view to reload itself
    [self.cardCollectionView reloadData];
    // Update the user interface and scroll to the top of the view
    [self updateUI];
    // Scroll to the first cell
    [self.cardCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

@end
