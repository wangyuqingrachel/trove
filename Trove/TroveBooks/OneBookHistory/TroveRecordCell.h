//
//  TroveRecordCell.h
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import <UIKit/UIKit.h>
#import "TroveRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TroveRecordCell : UICollectionViewCell

+ (NSString *)identifier;
- (void)configWithColor:(UIColor *)color recordModel:(TroveRecordModel *)book isEnd:(BOOL)isEnd;

@end

NS_ASSUME_NONNULL_END
