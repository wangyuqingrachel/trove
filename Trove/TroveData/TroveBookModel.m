//
//  TroveBookModel.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveBookModel.h"

@implementation TroveBookModel

- (instancetype)initWithTitle:(NSString *)title pages:(NSNumber *)pages colorType:(TroveColorType)colorType
{
    self = [super init];
    if (self) {
        _bookTitle = title;
        _totalPages = pages;
        _color = colorType;
        _records = [NSMutableArray new];
    }
    return self;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.bookTitle forKey:@"book_title"];
    [encoder encodeObject:self.totalPages forKey:@"total_pages"];
    [encoder encodeInt:[@(self.color) intValue] forKey:@"color"];
    [encoder encodeObject:self.records forKey:@"records"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.bookTitle = [decoder decodeObjectForKey:@"book_title"];
        self.totalPages = [decoder decodeObjectForKey:@"total_pages"];
        self.color = [decoder decodeIntForKey:@"color"];
        self.records = [decoder decodeObjectForKey:@"records"];
    }
    return self;
}

@end
