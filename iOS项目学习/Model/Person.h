//
//  Person.h
//  iOS项目学习
//
//  Created by valenty on 16/2/21.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject <NSCoding>


@property(nonatomic,strong) NSString *name;
@property(strong,nonatomic) UIImage *userImage;
@property(assign,nonatomic) NSString *age;
@property(nonatomic,strong) NSString *phone;

+(id) initPersonWithName:(NSString *)name andImage:(UIImage *)image andAge:(NSString *)age andPhone:(NSString *)phone;


@end
