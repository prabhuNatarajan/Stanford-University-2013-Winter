//
//  CardView.m
//  GraphicalSet
//
//  Created by Apple on 10/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (void)setup
{
    // Custom initialization
}

// UIView: Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
- (void)awakeFromNib
{
    [self setup];
}

// UIView: Initializes and returns a newly allocated view object with the specified frame rectangle.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Custom initialization
        [self setup];
    }
    return self;
}

// Sets the playing card face-up state this view represents.
- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    
    [self setNeedsDisplay];
}

// Sets the playing card unplayable state this view represents.
- (void)setUnplayable:(BOOL)unplayable
{
    _unplayable = unplayable;
    
    [self setNeedsDisplay];
}

@end
