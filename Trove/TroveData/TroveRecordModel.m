//
//  TroveRecordModel.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveRecordModel.h"

@implementation TroveRecordModel

- (instancetype)initWithDate:(NSDate *)date page:(NSNumber *)page note:(NSString *)note
{
    self = [super init];
    if (self) {
        _date = date;
        _page = page;
        _note = note;
    }
    return self;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeBool:self.page forKey:@"page"];
    [encoder encodeBool:self.note forKey:@"note"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.date = [decoder decodeObjectForKey:@"date"];
        self.page = [decoder decodeObjectForKey:@"page"];
        self.note = [decoder decodeObjectForKey:@"note"];
    }
    return self;
}

@end
