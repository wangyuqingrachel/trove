//
//  TroveMacro.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 通知
#define TroveBookCreateNotification @"TroveBookCreateNotification"

// 系统声音 1050 - 1200 都还可以
#define kAudioArchive (1104)
#define kAudioClick (1123)

@interface TroveMacro : NSObject

@end

NS_ASSUME_NONNULL_END
