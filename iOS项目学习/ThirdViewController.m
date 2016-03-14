//
//  ThirdViewController.m
//  iOS项目学习
//
//  Created by valenty on 16/2/13.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController () <NSURLConnectionDataDelegate> {
    UITextField *myTextField;
    NSMutableData *serverData;
}

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblCatalog = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 450, 200)];
    lblCatalog.text = @"网络传输请求步骤：\n 1、NSURL(地址)\n 2、NSURLRequest(Get请求)\n 3、NSMutableURLRequest(Post请求)\n 4、NSURLConnection(连接) \n NSRULConnectionDataDelegate常用的代理方法\n，处理请求返回的结果";
    lblCatalog.numberOfLines = 0;
    lblCatalog.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lblCatalog];
    
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblCatalog.frame) + 10, 300, 32)];
    myTextField.layer.borderWidth = 1;
    myTextField.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:myTextField];
    
    
    UIButton *btnPlistSaveData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(myTextField.frame)+30, 100, 25)];
    [btnPlistSaveData addTarget:self action:@selector(getRequest) forControlEvents:UIControlEventTouchUpInside];
    btnPlistSaveData.backgroundColor = [UIColor redColor];
    btnPlistSaveData.titleLabel.font = [UIFont systemFontOfSize:12];
    btnPlistSaveData.layer.cornerRadius = 3;
    [btnPlistSaveData setTitle:@"GET请求" forState:UIControlStateNormal];
    [self.view addSubview:btnPlistSaveData];
    
}

//Get请求
-(void) getRequest {
    NSString *strContent = myTextField.text;
    NSString *strUrl =@"http://www.cocoachina.com/"; [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@&rsv_spt=1&rsv_iqid=0xb4a2541700003e13&issp=1&f=8&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_sug2=0&inputT=169&rsv_sug4=170",strContent];
    //中文字符串UTF-8转码
    NSURL *getUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
//    NSLog(@"%@",getUrl);
//需要在info.plist新增允许网络请求
//    <key>NSAppTransportSecurity</key>
//    <dict>
//         <key>NSAllowsArbitraryLoads</key>
//         <true/>
//    </dict>
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:getUrl];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestUrl delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"开始接收数据请求");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    NSLog(@"AAAA:%@",data);
    //拼接数据，数据是断续的
    if (serverData==nil) {
        serverData = [NSMutableData data];
    }
    [serverData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"接收的最终数据：%@",serverData);
    //解析数据
    NSString *stringData = [[NSString alloc] initWithData:serverData encoding:NSUTF8StringEncoding];
    NSLog(@"stringData:%@",stringData);
}


//Post请求
-(void) postRequest {
    
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
