//
//  UIColor+TroveColor.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, TroveUserInterfaceStyle) {
    TroveUserInterfaceStyleLight,
    TroveUserInterfaceStyleDark,
};

typedef NS_ENUM(NSInteger, TroveColorType) {
    
    TroveColorTypeCellPink =  0,
    TroveColorTypeCellPinkPulse =  1,
    TroveColorTypeCellOrange = 2,
    TroveColorTypeCellOrangePulse = 3,
    TroveColorTypeCellYellow = 4,
    TroveColorTypeCellYellowPulse = 5,
    TroveColorTypeCellGreen = 6,
    TroveColorTypeCellGreenPulse = 7,
    TroveColorTypeCellTeal = 8,
    TroveColorTypeCellTealPulse = 9,
    TroveColorTypeCellBlue = 10,
    TroveColorTypeCellBluePulse = 11,
    TroveColorTypeCellPurple = 12,
    TroveColorTypeCellPurplePulse = 13,
    TroveColorTypeCellGray = 14,
    TroveColorTypeCellGrayPulse = 15,
    
    // 后续添加颜色从这里添加
    
    TroveColorTypeBackground,               // 主背景色
    TroveColorTypeTabbarIconText,           // tabbar item 未选中的颜色
    TroveColorTypeTabbarIconTextHightlight, // tabbar item 被选中的颜色
    TroveColorTypeText,                     // 文字颜色
    TroveColorTypeTextHint,                 // 文字备注颜色
    TroveColorTypeShadow,                   // 阴影颜色
    TroveColorTypeAddTaskCellBG,            // add task cell的背景颜色
    TroveColorTypeAddTaskCellPlus,          // add task cell的加号颜色
};

@interface UIColor (TroveColor)

+ (UIColor *)troveColorNamed:(TroveColorType)colorType;
+ (TroveColorType)trove_getPulseColorType:(TroveColorType)color;

@end

NS_ASSUME_NONNULL_END
