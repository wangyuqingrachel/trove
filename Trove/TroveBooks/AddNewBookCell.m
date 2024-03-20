//
//  AddNewBookCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "AddNewBookCell.h"
#import <Masonry/Masonry.h>

static CGFloat const kShadowWidth = 5;

@interface AddNewBookCell ()

@property (nonatomic, strong) UIImageView *addIconView;

@end

@implementation AddNewBookCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setupUI];
    }
    return self;
}

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (void)config
{
    [self p_setupUI];
}

- (void)p_setupUI
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kShadowWidth);
        make.right.offset(-kShadowWidth);
        make.top.offset(kShadowWidth);
        make.bottom.offset(-kShadowWidth);
    }];
    self.contentView.backgroundColor = [UIColor grayColor];
    self.contentView.layer.cornerRadius = 14;
    [self.contentView addSubview:self.addIconView];
    [self.addIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - Getters

- (UIImageView *)addIconView
{
    if (!_addIconView) {
        UIImage *image = [[UIImage systemImageNamed:@"plus"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addIconView = [[UIImageView alloc]initWithImage:image];
        [_addIconView setTintColor:[UIColor blackColor]];
    }
    return _addIconView;
}


@end
