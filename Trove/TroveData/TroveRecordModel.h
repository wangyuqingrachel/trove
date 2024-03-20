//
//  TroveRecordModel.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TroveRecordModel : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSString *note;

- (instancetype)initWithDate:(NSDate *)date page:(NSNumber *)page note:(NSString *)note;

@end

NS_ASSUME_NONNULL_END
