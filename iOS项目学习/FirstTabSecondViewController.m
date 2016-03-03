//
//  FirstTabSecondViewController.m
//  iOS项目学习
//
//  Created by valenty on 16/2/13.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "FirstTabSecondViewController.h"
#import "FirstTabViewController.h"

@interface FirstTabSecondViewController ()

@end

@implementation FirstTabSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"标题";
    
    [self buildBackFirstVC];
}

-(void) buildBackFirstVC {
    UIButton *btnBackFirst = [[UIButton alloc] init];
    btnBackFirst.frame = CGRectMake(100, 100, 180, 50);
    [btnBackFirst setTitle:@"返回第一个控制器" forState:UIControlStateNormal];
    [btnBackFirst setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnBackFirst.backgroundColor = [UIColor redColor];
    btnBackFirst.layer.cornerRadius = 3;
    [btnBackFirst addTarget:self action:@selector(backFirstVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBackFirst];
}

-(void) backFirstVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
