//
//  TroveBookCell.h
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import <UIKit/UIKit.h>
#import "TroveBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TroveBookCell : UICollectionViewCell

+ (NSString *)identifier;
+ (CGFloat)cellHeight;
- (void)configWithBookModel:(TroveBookModel *)book;

@end

NS_ASSUME_NONNULL_END
