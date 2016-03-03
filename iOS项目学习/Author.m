//
//  Author.m
//  iOS项目学习
//
//  Created by valenty on 16/3/1.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "Author.h"

@implementation Author

+(id) initAuthorWithName:(NSString *)name andImage:(UIImage *)image andAge:(NSString *)age andPhone:(NSString *)phone andBookName:(NSString *)bookName {
    Author *author = [[Author alloc] init];
    author.name = name;
    author.userImage = image;
    author.age = age;
    author.phone = phone;
    author.bookName = bookName;
    return author;
}

//编码
-(void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_bookName forKey:@"bookName"];
}

//解码
-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _bookName = [aDecoder decodeObjectForKey:@"bookName"];
    }
    return self;
}

@end
