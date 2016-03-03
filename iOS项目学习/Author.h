//
//  Author.h
//  iOS项目学习
//
//  Created by valenty on 16/3/1.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "Person.h"

@interface Author : Person <NSCoding>

@property(strong,nonatomic) NSString *bookName;

+(id) initAuthorWithName:(NSString *)name andImage:(UIImage *)image andAge:(NSString *)age andPhone:(NSString *)phone andBookName:(NSString *)bookName;

@end
