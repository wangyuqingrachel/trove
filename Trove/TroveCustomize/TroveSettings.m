//
//  TroveSettings.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "TroveSettings.h"
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
