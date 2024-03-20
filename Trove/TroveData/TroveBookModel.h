//
//  TroveBookModel.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import <Foundation/Foundation.h>
#import "TroveRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TroveBookModel : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, strong) NSNumber *totalPages;
@property (nonatomic, strong) NSMutableArray<TroveRecordModel *> *records;

- (instancetype)initWithTitle:(NSString *)title pages:(NSNumber *)pages;

@end

NS_ASSUME_NONNULL_END
