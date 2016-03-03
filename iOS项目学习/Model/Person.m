//
//  Person.m
//  iOS项目学习
//
//  Created by valenty on 16/2/21.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "Person.h"

@implementation Person


+(id) initPersonWithName:(NSString *)name andImage:(UIImage *)image andAge:(NSString *)age andPhone:(NSString *)phone{
    Person *person = [[Person alloc] init];
    person.name = name;
    person.userImage = image;
    person.age = age;
    person.phone = phone;
    
    return person;
}

#pragma mark 实现NSCode代理
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    NSData *data = UIImageJPEGRepresentation(_userImage, 1.0);
    [aCoder encodeObject:data forKey:@"imageData"];
    [aCoder encodeObject:_age forKey:@"age"];
    [aCoder encodeObject:_phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        
        NSData *imageData = [aDecoder decodeObjectForKey:@"imageData"];
        [self setUserImage:[UIImage imageWithData:imageData]];
        
        [self setAge:[aDecoder decodeObjectForKey:@"age"]];
        [self setPhone:[aDecoder decodeObjectForKey:@"phone"]];
    }
    return self;
}


@end
