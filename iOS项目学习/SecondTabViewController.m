//
//  SecondTabViewController.m
//  iOS项目学习
//
//  Created by valenty on 16/2/13.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "SecondTabViewController.h"

@interface SecondTabViewController () {
    NSString *strContent;
    
}
@property(strong,nonatomic) UILabel *usernameLabel;
@property(strong,nonatomic) UILabel *contentLabel;

@end

@implementation SecondTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    self.usernameLabel.text = @"用户名Jordan CZ: ";
    self.usernameLabel.adjustsFontSizeToFitWidth = YES ;
    [self.usernameLabel sizeToFit];
    
    strContent = @"首行缩进根据用户昵称自动调整 间隔可自定根据需求随意改变。。。。";
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 150)];
    self.contentLabel.text = strContent;
    self.contentLabel.layer.borderColor = [[UIColor redColor] CGColor];
    self.contentLabel.layer.borderWidth = 1;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.adjustsFontSizeToFitWidth=YES;
    self.contentLabel.adjustsLetterSpacingToFitWidth=YES;
    
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.usernameLabel];
    
    [self resetContent];
}

//自适应计算间距
- (void)resetContent{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft ;
    paragraphStyle.maximumLineHeight = 60 ;  //最大的行高
    paragraphStyle.lineSpacing = 5 ;  //行自定义行高度
    [paragraphStyle setFirstLineHeadIndent:50]; //首行缩进 根据用户昵称宽度在加5个像素
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    self.contentLabel.attributedText = attributedString;
    [self.contentLabel sizeToFit];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
