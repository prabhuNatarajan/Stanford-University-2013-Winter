//
//  CardGameConstants.h
//  GraphicalSet
//
//  Created by Apple on 09/07/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#define OK_BUTTON_TITLE @"Ok"
#define CANCEL_BUTTON_TITLE @"Cancel"
#define OK_BUTTON_INDEX 1
#define CANCEL_BUTTON_INDEX 0

typedef enum
{
    SetCardSymbolDiamond = 1, SetCardSymbolSquiggle = 2, SetCardSymbolOval = 3
}SetCardSymbol;

typedef enum
{
    SetCardShadingSolid = 1, SetCardShadingStriped = 2, SetCardShadingOpen = 3
}SetCardShading;

typedef enum
{
    SetCardColorRed = 1, SetCardColorGreen = 2, SetCardColorPurple = 3
}SetCardColor;
