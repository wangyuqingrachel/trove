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

@interface TroveStorage : NSObject

+ (void)createBook:(TroveBookModel *)newbook;
+ (void)editBook:(NSString *)originalname toBook:(TroveBookModel *)newbook;
+ (void)addRecord:(TroveRecordModel *)record toBook:(NSString *)bookTitle;

+ (TroveBookModel *)getBook:(NSString *)bookTitle;

+ (BOOL)bookNameExists:(NSString *)newBookName;
+ (void)saveTroveBooks:(NSMutableArray<TroveBookModel *> *)books; // 归档
+ (NSMutableArray<TroveBookModel *> *)retriveTroveBooks; // 解档

@end

NS_ASSUME_NONNULL_END
