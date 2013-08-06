//
//  SetCardView.m
//  GraphicalSet
//
//  Created by Apple on 11/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SetCardView.h"

#define CORNER_RADIUS 4.0
#define MAX_SYMBOLS_TO_FIT 3
#define SYMBOL_WIDTH_PERCENTAGE .6
#define SYMBOL_HEIGHT_PERCENTAGE .7
#define PATH_LINE_WIDTH 2.0
#define STRIPE_STEPS 3

@implementation SetCardView

// Sets the symbol of this card.
- (void)setSymbol:(SetCardSymbol)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

// Sets the shading of this card.
- (void)setShading:(SetCardShading)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

// Sets the color of this card.
- (void)setColor:(SetCardColor)color
{
    _color = color;    
    [self setNeedsDisplay];
}

// Sets the number of this card.
- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

// Sets the playing card matched state this view represents.
- (void)setMatched:(BOOL)matched
{
    _matched = matched;
    [self setNeedsDisplay];
}

// UIView: Draws the receiver’s image within the passed-in rectangle.
- (void)drawRect:(CGRect)rect
{
    // Define a rectangle with rounded corners as the clipping area
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    // Fill the inside of the rectangle
    UIColor *backgroundColor = (self.isFaceUp) ? [UIColor colorWithRed:0.900 green:0.900 blue:0.900 alpha:1.000] : [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
    [backgroundColor setFill];
    UIRectFill(self.bounds);
    // Color the lines of the rectangle
    UIColor *strokeColor = (self.isMatched && self.isUnplayable) ? [UIColor greenColor] : (self.isMatched && !self.isUnplayable) ? [UIColor redColor] : [UIColor grayColor];
    [strokeColor setStroke];
    [roundedRect stroke];
    // Draw the symbols
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = PATH_LINE_WIDTH;
    [self drawSymbolsOnPath:path];
    // Check whether any symbols were drawn
    if (![path isEmpty])
    {
        // Color the lines of the symbols
        UIColor *strokeColor = (self.color == SetCardColorRed) ? [UIColor redColor] : (self.color == SetCardColorGreen) ? [UIColor greenColor] : (self.color == SetCardColorPurple) ? [UIColor purpleColor] : [UIColor whiteColor];
        [strokeColor setStroke];
        [path stroke];
        // Fill the inside of the symbols
        UIColor *fillColor = (self.shading == SetCardShadingSolid) ? strokeColor : backgroundColor;
        [fillColor setFill];
        [path fill];
        if (self.shading == SetCardShadingStriped)
        {
            [self drawStripesOnPath:path strokeColor:strokeColor];
        }
    }
}

// Draws the symbols of this card on the given path.
- (void)drawSymbolsOnPath:(UIBezierPath *)path
{
    CGFloat symbolWidth = (self.bounds.size.width / MAX_SYMBOLS_TO_FIT) * SYMBOL_WIDTH_PERCENTAGE;
    CGFloat symbolHeight = self.bounds.size.height * SYMBOL_HEIGHT_PERCENTAGE;
    CGFloat symbolStartY = (self.bounds.size.height - symbolHeight) / 2.0;
    for (int count = 1; count <= self.number; count++)
    {
        CGFloat symbolStartX = (self.bounds.size.width / (self.number + 1)) * count;
        switch (self.symbol)
        {
            case SetCardSymbolDiamond:
            {
                [self drawDiamondOnPath:path point:CGPointMake(symbolStartX, symbolStartY) size:CGSizeMake(symbolWidth, symbolHeight)];
                break;
            }
            case SetCardSymbolSquiggle:
            {
                [self drawSquiggleOnPath:path point:CGPointMake(symbolStartX, symbolStartY) size:CGSizeMake(symbolWidth, symbolHeight)];
                break;
            }
            case SetCardSymbolOval:
            {
                [self drawOvalOnPath:path point:CGPointMake(symbolStartX, symbolStartY) size:CGSizeMake(symbolWidth, symbolHeight)];
                break;
            }
            default:
            {
                break;
            }
        }
    }
}

// Draws a diamond symbol on the given path, at the given bounds location, and of the given size.
- (void)drawDiamondOnPath:(UIBezierPath *)path point:(CGPoint)point size:(CGSize)size
{
    [path moveToPoint:CGPointMake(point.x, point.y)];
    [path addLineToPoint:CGPointMake(point.x + (size.width / 2.0), point.y + (size.height / 2.0))];
    [path addLineToPoint:CGPointMake(point.x, point.y + size.height)];
    [path addLineToPoint:CGPointMake(point.x - (size.width / 2.0), point.y + (size.height / 2.0))];
    [path closePath];
}

// Draws a squiggle symbol on the given path, at the given bounds location, and of the given size.
- (void)drawSquiggleOnPath:(UIBezierPath *)path point:(CGPoint)point size:(CGSize)size
{
    [path moveToPoint:CGPointMake(point.x - (size.width / 4.0), point.y + (size.width / 8.0))];
    [path addQuadCurveToPoint:CGPointMake(point.x + (size.width / 2.0), point.y + (size.width / 8.0)) controlPoint:CGPointMake(point.x, point.y - (size.width / 8.0))];
    [path addCurveToPoint:CGPointMake(point.x + (size.width / 2.0), (point.y + size.height) - (size.width / 8.0))
            controlPoint1:CGPointMake(point.x + (size.width / 1.0), (point.y + size.height) / 2.0)
            controlPoint2:CGPointMake(point.x - (size.width / 4.0), (point.y + size.height) / 2.0)];
    [path addQuadCurveToPoint:CGPointMake(point.x - (size.width / 4.0), (point.y + size.height) - (size.width / 8.0)) controlPoint:CGPointMake(point.x, (point.y + size.height) + (size.width / 8.0))];
    [path addCurveToPoint:CGPointMake(point.x - (size.width / 4.0), point.y + (size.width / 8.0))
            controlPoint1:CGPointMake(point.x - (size.width / 1.0), (point.y + size.height) / 2.0)
            controlPoint2:CGPointMake(point.x + (size.width / 12.0), (point.y + size.height) / 2.0)];
    [path closePath];
}

// Draws an oval symbol on the given path, at the given bounds location, and of the given size.
- (void)drawOvalOnPath:(UIBezierPath *)path point:(CGPoint)point size:(CGSize)size
{
    [path moveToPoint:CGPointMake(point.x - (size.width / 2.0), point.y + (size.width / 2.0))];
    [path addArcWithCenter:CGPointMake(point.x, point.y + (size.width / 2.0)) radius:(size.width / 2.0) startAngle:M_PI endAngle:0.0 clockwise:YES];
    [path addLineToPoint:CGPointMake(point.x + (size.width / 2.0), (point.y + size.height) - (size.width / 2.0))];
    [path addArcWithCenter:CGPointMake(point.x, (point.y + size.height) - (size.width / 2.0)) radius:(size.width / 2.0) startAngle:0.0 endAngle:M_PI clockwise:YES];
    [path closePath];
}

// Fills the given path with horizontal stripe lines of the given color.
- (void)drawStripesOnPath:(UIBezierPath *)path strokeColor:(UIColor *)strokeColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [path addClip];
    UIBezierPath *stripesPath = [[UIBezierPath alloc] init];
    stripesPath.lineWidth = PATH_LINE_WIDTH / 2.5;
    for (int i = 0; i < self.bounds.size.height; i += STRIPE_STEPS)
    {
        [stripesPath moveToPoint:CGPointMake(0.0, i)];
        [stripesPath addLineToPoint:CGPointMake(self.bounds.size.width, i)];
        [stripesPath closePath];
    }
    [strokeColor setStroke];
    [stripesPath stroke];
    [[UIColor whiteColor] setFill];
    [stripesPath fill];
    CGContextRestoreGState(context);
}

@end
