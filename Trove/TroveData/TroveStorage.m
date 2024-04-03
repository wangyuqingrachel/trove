//
//  TroveStorage.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveStorage.h"
#import "TroveMacro.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation TroveStorage

+ (void)createBook:(TroveBookModel *)newbook
{
    NSMutableArray <TroveBookModel *> *books = [TroveStorage retriveTroveBooks];
    [books insertObject:newbook atIndex:0];
    NSLog(@"Create a book");
    [TroveStorage saveTroveBooks:books];
    [[NSNotificationCenter defaultCenter] postNotificationName:TroveBookCreateNotification object:nil userInfo:nil];
    AudioServicesPlaySystemSound((SystemSoundID)kAudioClick);
}

+ (void)editBook:(NSString *)originalname toBook:(TroveBookModel *)newbook
{
    NSMutableArray <TroveBookModel *> *books = [TroveStorage retriveTroveBooks];
    NSInteger targetIndex = NSNotFound;
    for (int i=0; i<books.count; i++) {
        if ([books[i].bookTitle isEqualToString:originalname]) {
            targetIndex = i;
            break;
        }
    }
    if (targetIndex != NSNotFound) {
        books[targetIndex].bookTitle = newbook.bookTitle;
        books[targetIndex].totalPages = newbook.totalPages;
        books[targetIndex].color = newbook.color;
        NSLog(@"Edit a book");
        [TroveStorage saveTroveBooks:books];
        [[NSNotificationCenter defaultCenter] postNotificationName:TroveBookEditNotification object:nil userInfo:nil];
        AudioServicesPlaySystemSound((SystemSoundID)kAudioClick);
    }
}

+ (void)addRecord:(TroveRecordModel *)record toBook:(NSString *)bookTitle
{
    NSMutableArray <TroveBookModel *> *books = [TroveStorage retriveTroveBooks];
    for (int i=0; i<books.count; i++) {
        if ([books[i].bookTitle isEqualToString:bookTitle]) {
            NSMutableArray<TroveRecordModel *> *records = books[i].records;
            [records insertObject:record atIndex:0];
            NSLog(@"Add a record");
            books[i].records = records;
            [TroveStorage saveTroveBooks:books];
            [[NSNotificationCenter defaultCenter] postNotificationName:TroveRecordAddNotification object:nil userInfo:nil];
            AudioServicesPlaySystemSound((SystemSoundID)kAudioClick);
            break;
        }
    }
}

+ (TroveBookModel *)getBook:(NSString *)bookTitle
{
    NSMutableArray <TroveBookModel *> *books = [TroveStorage retriveTroveBooks];
    for (int i=0; i<books.count; i++) {
        if ([books[i].bookTitle isEqualToString:bookTitle]) {
            return books[i];
        }
    }
    return [TroveBookModel new];
}

+ (BOOL)bookNameExists:(NSString *)newBookName
{
    NSMutableArray <TroveBookModel *> *tasks = [TroveStorage retriveTroveBooks];
    for (int i=0; i<tasks.count; i++) {
        if ([tasks[i].bookTitle isEqualToString:newBookName]) {
            return YES;
        }
    }
    return NO;
}

+ (void)saveTroveBooks:(NSMutableArray<TroveBookModel *> *)books // 归档
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@{@"books":books} requiringSecureCoding:YES error:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"trove.data"];
    [data writeToFile:filePath atomically:YES];
}

+ (NSMutableArray<TroveBookModel *> *)retriveTroveBooks // 解档
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"trove.data"];
    NSData *storedEncodedObject = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
    NSDictionary *dataDict = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[TroveBookModel.class, TroveRecordModel.class, NSMutableArray.class, NSArray.class, NSDictionary.class, NSString.class, NSNumber.class, NSDate.class]] fromData:storedEncodedObject error:nil];
    BOOL isValid = [dataDict.allKeys containsObject:@"books"];
    if (isValid) {
        NSMutableArray<TroveBookModel *> *books = dataDict[@"books"];
        return books;
    } else {
        return [NSMutableArray new];
    }
}

@end
