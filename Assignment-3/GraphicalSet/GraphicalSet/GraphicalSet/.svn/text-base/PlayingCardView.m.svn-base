//
//  PlayingCardView.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "PlayingCardView.h"

#define FACE_CARD_SCALE_FACTOR 0.90
#define CORNER_RADIUS 4.0
#define PIP_FONT_SCALE_FACTOR 0.16
#define CORNER_OFFSET 0.5
#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

@implementation PlayingCardView


// Sets the playing card rank this view represents.
- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

// Sets the playing card suit this view represents.
- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

// Returns the playing card rank this view represents as a string.
- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

// UIView: Draws the receiver’s image within the passed-in rectangle.
- (void)drawRect:(CGRect)rect
{
    // Define a rectangle with rounded corners as the clipping area
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];    
    // Make the whole rectangle white
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);    
    // Check whether the card is face-up
    if (self.faceUp)
    {
        // Check whether there's an image to represent the card
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [self rankAsString], self.suit]];
        if (faceImage)
        {
            // We have an image - use it
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - FACE_CARD_SCALE_FACTOR), self.bounds.size.height * (1.0 - FACE_CARD_SCALE_FACTOR));
            [faceImage drawInRect:imageRect];
        }
        else
        {
            // We don't have an image - fill the card with pips
            [self drawPips];
        }
        
        // Draw the contents that go on the card's corners
        [self drawCorners];
    }
    else
    {
        // Use the card back image
        [[UIImage imageNamed:@"images.jpeg"] drawInRect:self.bounds];
    }
    // Use a black stroke for the rectangle's sides
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

// Draws the card corner images.
- (void)drawCorners
{
    // Set the text attributes that make up the contents of the card's corners
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : cornerFont}];
    // Draw the top-left content
    CGRect textBounds;
    textBounds.origin = CGPointMake(CORNER_OFFSET, CORNER_OFFSET);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    // Draw the bottom-right content after translating and rotating the context
    [self pushContextAndRotateUpsideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
}

// Saves a copy of the current context's graphics state onto the graphics state stack, before moving and rotating the context 180 degrees.
- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

// Restores the current graphics context.
- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

// Draws the card pips.
- (void)drawPips
{
    if (self.rank == 1 || self.rank == 5 || self.rank == 9 || self.rank == 3)
    {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:0 mirroredVertically:NO];
    }
    if (self.rank == 6 || self.rank == 7 || self.rank == 8)
    {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:0 mirroredVertically:NO];
    }
    if (self.rank == 2 || self.rank == 3 || self.rank == 7 || self.rank == 8 || self.rank == 10)
    {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:PIP_VOFFSET2_PERCENTAGE mirroredVertically:(self.rank != 7)];
    }
    if (self.rank == 4 || self.rank == 5 || self.rank == 6 || self.rank == 7 || self.rank == 8 || self.rank == 9 || self.rank == 10)
    {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET3_PERCENTAGE mirroredVertically:YES];
    }
    if (self.rank == 9 || self.rank == 10)
    {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVertically:YES];
    }
}

// Draws the card pips with horizontal spacing and mirrored as necessary.
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
    if (mirroredVertically)
    {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
    }
}

// Draws the card pips with horizontal spacing and upside-down as necessary.
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset upsideDown:(BOOL)upsideDown
{
    if (upsideDown)
    {
        [self pushContextAndRotateUpsideDown];
    }
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName : pipFont}];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width / 2.0 - hoffset * self.bounds.size.width, middle.y - pipSize.height / 2.0 - voffset * self.bounds.size.height);
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset)
    {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown)
    {
        [self popContext];
    }
}

@end
