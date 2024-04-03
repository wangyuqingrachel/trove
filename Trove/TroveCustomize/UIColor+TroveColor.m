//
//  UIColor+TroveColor.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/24.
//

#import "UIColor+TroveColor.h"
#import "TroveSettings.h"

@implementation UIColor (TroveColor)

+ (UIColor *)troveColorNamed:(TroveColorType)colorType
{
    BOOL isLight = ![TroveSettings appliedDarkMode];
    switch (colorType) {
        case TroveColorTypeBackground:
            return isLight ? [UIColor whiteColor] : [UIColor blackColor];
        case TroveColorTypeTabbarIconText:
            return [UIColor grayColor];
        case TroveColorTypeTabbarIconTextHightlight:
            return isLight ? [UIColor blackColor] : [UIColor whiteColor];
        case TroveColorTypeText:
            return isLight ? [UIColor blackColor] : [UIColor whiteColor];
        case TroveColorTypeTextHint: // 和cell gray pulse一样
            return isLight ? [UIColor trove_darkGray] : [UIColor trove_lightGray];
        case TroveColorTypeShadow:
            return [UIColor grayColor];
        case TroveColorTypeAddTaskCellBG:
            return isLight ? [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] : [UIColor colorWithRed:15/255.0 green:15/255.0 blue:15/255.0 alpha:1];
        case TroveColorTypeAddTaskCellPlus:
            return isLight ? [UIColor colorWithRed:200/255.0 green: 200/255.0  blue:200/255.0 alpha:1] : [UIColor colorWithRed:55/255.0 green: 55/255.0  blue:55/255.0 alpha:1];
        case TroveColorTypeCellPink:
            return isLight ? [UIColor trove_lightPink] : [UIColor trove_darkPink];
        case TroveColorTypeCellPinkPulse:
            return isLight ? [UIColor trove_darkPink] : [UIColor trove_lightPink];
        case TroveColorTypeCellOrange:
            return isLight ? [UIColor trove_lightOrange] : [UIColor trove_darkOrange];
        case TroveColorTypeCellOrangePulse:
            return isLight ? [UIColor trove_darkOrange] : [UIColor trove_lightOrange];
        case TroveColorTypeCellYellow:
            return isLight ? [UIColor trove_lightYellow] : [UIColor trove_darkYellow];
        case TroveColorTypeCellYellowPulse:
            return isLight ? [UIColor trove_darkYellow] : [UIColor trove_lightYellow];
        case TroveColorTypeCellGreen:
            return isLight ? [UIColor trove_lightGreen] : [UIColor trove_darkGreen];
        case TroveColorTypeCellGreenPulse:
            return isLight ? [UIColor trove_darkGreen] : [UIColor trove_lightGreen];
        case TroveColorTypeCellTeal:
            return isLight ? [UIColor trove_lightTeal] : [UIColor trove_darkTeal];
        case TroveColorTypeCellTealPulse:
            return isLight ? [UIColor trove_darkTeal] : [UIColor trove_lightTeal];
        case TroveColorTypeCellBlue:
            return isLight ? [UIColor trove_lightBlue] : [UIColor trove_darkBlue];
        case TroveColorTypeCellBluePulse:
            return isLight ? [UIColor trove_darkBlue] : [UIColor trove_lightBlue];
        case TroveColorTypeCellPurple:
            return isLight ? [UIColor trove_lightPurple] : [UIColor trove_darkPurple];
        case TroveColorTypeCellPurplePulse:
            return isLight ? [UIColor trove_darkPurple] : [UIColor trove_lightPurple];
        case TroveColorTypeCellGray:
            return isLight ? [UIColor trove_lightGray] : [UIColor trove_darkGray];
        case TroveColorTypeCellGrayPulse:
            return isLight ? [UIColor trove_darkGray] : [UIColor trove_lightGray];
        default:
            return [UIColor clearColor];
    }
}

+ (UIColor *)trovePulseColorType:(TroveColorType)colorType
{
    switch (colorType) {
        case TroveColorTypeCellPink:
            return [UIColor troveColorNamed:TroveColorTypeCellPinkPulse];
        case TroveColorTypeCellOrange:
            return [UIColor troveColorNamed:TroveColorTypeCellOrangePulse];
        case TroveColorTypeCellYellow:
            return [UIColor troveColorNamed:TroveColorTypeCellYellowPulse];
        case TroveColorTypeCellGreen:
            return [UIColor troveColorNamed:TroveColorTypeCellGreenPulse];
        case TroveColorTypeCellTeal:
            return [UIColor troveColorNamed:TroveColorTypeCellTealPulse];
        case TroveColorTypeCellBlue:
            return [UIColor troveColorNamed:TroveColorTypeCellBluePulse];
        case TroveColorTypeCellPurple:
            return [UIColor troveColorNamed:TroveColorTypeCellPurplePulse];
        case TroveColorTypeCellGray:
            return [UIColor troveColorNamed:TroveColorTypeCellGrayPulse];
            
        case TroveColorTypeCellPinkPulse:
            return [UIColor troveColorNamed:TroveColorTypeCellPink];;
        case TroveColorTypeCellOrangePulse:
            return [UIColor troveColorNamed:TroveColorTypeCellOrange];
        case TroveColorTypeCellYellowPulse:
            return [UIColor troveColorNamed:TroveColorTypeCellYellow];
        case TroveColorTypeCellGreenPulse:
            return [UIColor troveColorNamed:TroveColorTypeCellGreen];
        case TroveColorTypeCellTealPulse:
            return [UIColor troveColorNamed:TroveColorTypeCellTeal];
        case TroveColorTypeCellBluePulse:
            return [UIColor troveColorNamed:TroveColorTypeCellBlue];
        case TroveColorTypeCellPurplePulse:
            return [UIColor troveColorNamed:TroveColorTypeCellPurple];
        case TroveColorTypeCellGrayPulse:
            return [UIColor troveColorNamed:TroveColorTypeCellGray];
        default:
            return [UIColor troveColorNamed:TroveColorTypeBackground];
    }
}

+ (UIColor *)trove_lightPink
{
    return [UIColor colorWithRed:224/255.0 green:205/255.0 blue:207/255.0 alpha:1]; // 莫兰迪粉
}

+ (UIColor *)trove_darkPink
{
    return [UIColor colorWithRed:170/255.0 green:117/255.0 blue:120/255.0 alpha:1]; // 莫兰迪深粉
}

+ (UIColor *)trove_lightOrange
{
    return [UIColor colorWithRed:233/255.0 green:217/255.0 blue:209/255.0 alpha:1]; // 莫兰迪橘
}

+ (UIColor *)trove_darkOrange
{
    return [UIColor colorWithRed:160/255.0 green:106/255.0 blue:80/255.0 alpha:1]; // 莫兰迪深橘
}

+ (UIColor *)trove_lightYellow
{
    return [UIColor colorWithRed:243/255.0 green:230/255.0 blue:211/255.0 alpha:1]; // 莫兰迪黄
}

+ (UIColor *)trove_darkYellow
{
    return [UIColor colorWithRed:168/255.0 green:132/255.0 blue:98/255.0 alpha:1]; // 莫兰迪深黄（棕）
}

+ (UIColor *)trove_lightGreen
{
    return [UIColor colorWithRed:224/255.0 green:235/255.0 blue:223/255.0 alpha:1]; // 莫兰迪绿
}

+ (UIColor *)trove_darkGreen
{
    return [UIColor colorWithRed:103/255.0 green:119/255.0 blue:91/255.0 alpha:1]; // 莫兰迪深绿
}

+ (UIColor *)trove_lightTeal
{
    return [UIColor colorWithRed:212/255.0 green:231/255.0 blue:234/255.0 alpha:1]; // 莫兰迪青
}

+ (UIColor *)trove_darkTeal
{
    return [UIColor colorWithRed:62/255.0 green:130/255.0 blue:141/255.0 alpha:1]; // 莫兰迪深青
}

+ (UIColor *)trove_lightBlue
{
    return [UIColor colorWithRed:198/255.0 green:208/255.0 blue:220/255.0 alpha:1]; // 莫兰迪蓝
}

+ (UIColor *)trove_darkBlue
{
    return [UIColor colorWithRed:104/255.0 green:120/255.0 blue:137/255.0 alpha:1]; // 莫兰迪深蓝
}

+ (UIColor *)trove_lightPurple
{
    return [UIColor colorWithRed:216/255.0 green:207/255.0 blue:226/255.0 alpha:1]; // 莫兰迪紫
}

+ (UIColor *)trove_darkPurple
{
    return [UIColor colorWithRed:105/255.0 green:100/255.0 blue:123/255.0 alpha:1]; // 莫兰迪深紫
}

+ (UIColor *)trove_lightGray
{
    return [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1]; // 莫兰迪灰
}

+ (UIColor *)trove_darkGray
{
    return [UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:1]; // 莫兰迪深灰
}

@end
