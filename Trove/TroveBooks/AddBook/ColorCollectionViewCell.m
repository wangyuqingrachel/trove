//
//  ColorCollectionViewCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "ColorCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TroveColor.h"

@implementation TroveColorModel // 数据源的类十分简单，直接写在cell里
@end

@interface ColorCollectionViewCell ()

@property (nonatomic, strong) UIImageView *selectedMarkView;

@end


@implementation ColorCollectionViewCell

- (void)configWithModel:(TroveColorModel *)model
{
    [self addSubview:self.selectedMarkView];
    [self.selectedMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = self.frame.size.width;
        make.width.height.mas_equalTo(width/2);
        make.centerX.centerY.offset(0);
    }];
    self.backgroundColor = [UIColor troveColorNamed:model.color];
    self.selectedMarkView.hidden = !model.isSelected;
}

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (UIImageView *)selectedMarkView
{
    if (!_selectedMarkView) {
        UIImage *image = [[UIImage systemImageNamed:@"heart.fill"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _selectedMarkView = [[UIImageView alloc]initWithImage:image];
        [_selectedMarkView setTintColor:[UIColor troveColorNamed:TroveColorTypeText]];
    }
    return _selectedMarkView;
}


@end
