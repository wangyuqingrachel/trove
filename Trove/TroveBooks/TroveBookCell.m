//
//  TroveBookCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveBookCell.h"

@implementation TroveBookCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (void)config
{
    self.backgroundColor = [UIColor yellowColor];
}

@end
