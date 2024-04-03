//
//  TroveSettings.h
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TroveSettings : NSObject

// Theme
+ (BOOL)appliedDarkMode;
+ (void)switchTheme;

@end

NS_ASSUME_NONNULL_END
