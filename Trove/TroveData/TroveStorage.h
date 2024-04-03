//
//  TroveStorage.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import <Foundation/Foundation.h>
#import "TroveBookModel.h"
#import "TroveRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BookNameExistsType) {
    BookNameExistsTypeValid, // 库里没有这个bookname，bookname合格
    BookNameExistsTypeExists,
};

@interface TroveStorage : NSObject

+ (void)createBook:(TroveBookModel *)newbook;
+ (BookNameExistsType)bookNameExists:(NSString *)newBookName;
+ (void)saveTroveBooks:(NSMutableArray<TroveBookModel *> *)books; // 归档
+ (NSMutableArray<TroveBookModel *> *)retriveTroveBooks; // 解档

@end

NS_ASSUME_NONNULL_END
