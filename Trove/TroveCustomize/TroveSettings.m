//
//  TroveSettings.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/24.
//

#import "TroveSettings.h"
#import "UIColor+TroveColor.h"
#import "TroveMacro.h"

@implementation TroveSettings

+ (BOOL)appliedDarkMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"TroveUserPreferredDarkMode"];
}

+ (void)switchTheme
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"TroveUserPreferredDarkMode"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TroveUserPreferredDarkMode"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TroveUserPreferredDarkMode"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TroveSwitchThemeNotification object:nil];
}

@end
