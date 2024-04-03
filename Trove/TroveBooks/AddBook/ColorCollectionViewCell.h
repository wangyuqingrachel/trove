//
//  ColorCollectionViewCell.h
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import <UIKit/UIKit.h>
#import "UIColor+TroveColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface TroveColorModel : NSObject // 数据源的类十分简单，直接写在cell里
@property (nonatomic, assign) TroveColorType color;
@property (nonatomic, assign) BOOL isSelected;
@end

@interface ColorCollectionViewCell : UICollectionViewCell


- (void)configWithModel:(TroveColorModel *)model;
+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
