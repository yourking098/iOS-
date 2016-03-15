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
    
    UILabel *lblCatalog = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 450, 170)];
    lblCatalog.text = @"网络传输请求步骤：\n 1、NSURL(地址)\n 2、NSURLRequest(Get请求)\n 3、NSMutableURLRequest(Post请求)\n 4、NSURLConnection(连接) \n NSRULConnectionDataDelegate常用的代理方法\n，处理请求返回的结果";
    lblCatalog.numberOfLines = 0;
    lblCatalog.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lblCatalog];
    
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblCatalog.frame) + 10, 300, 32)];
    myTextField.layer.borderWidth = 1;
    myTextField.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:myTextField];
    
    
    UIButton *btnNSURLConnectionGetRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(myTextField.frame)+30, 200, 25)];
    [btnNSURLConnectionGetRequest addTarget:self action:@selector(getRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLConnectionGetRequest.backgroundColor = [UIColor redColor];
    btnNSURLConnectionGetRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLConnectionGetRequest.layer.cornerRadius = 3;
    [btnNSURLConnectionGetRequest setTitle:@"NSURLConnection的GET请求" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLConnectionGetRequest];
    
    
    UIButton *btnNSURLSessionGetRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLConnectionGetRequest.frame)+10, 200, 25)];
    [btnNSURLSessionGetRequest addTarget:self action:@selector(getNSURLSessionRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLSessionGetRequest.backgroundColor = [UIColor redColor];
    btnNSURLSessionGetRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLSessionGetRequest.layer.cornerRadius = 3;
    [btnNSURLSessionGetRequest setTitle:@"NSURLSession的GET请求（推荐）" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLSessionGetRequest];
    
    
    UIButton *btnNSURLConnectionPostRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLSessionGetRequest.frame)+30, 200, 25)];
    [btnNSURLConnectionPostRequest addTarget:self action:@selector(postRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLConnectionPostRequest.backgroundColor = [UIColor redColor];
    btnNSURLConnectionPostRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLConnectionPostRequest.layer.cornerRadius = 3;
    [btnNSURLConnectionPostRequest setTitle:@"NSURLConnection的POST请求" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLConnectionPostRequest];
}

//使用NSURLConnection 的 Get请求
-(void) getRequest {
    
   NSString *strContent = myTextField.text;
   NSString *strUrl =@"http://www.cocoachina.com/"; // [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@&rsv_spt=1&rsv_iqid=0xb4a2541700003e13&issp=1&f=8&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&rsv_sug3=1&rsv_sug1=1&rsv_sug7=100&rsv_sug2=0&inputT=169&rsv_sug4=170",strContent];
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
    [strUrl sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(10, 80)];
}

#pragma mark NSURLConnectionDataDelegate
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
    serverData = [NSMutableData data];//释放数据
}

//使用NNSURLSession 的 Get请求
-(void) getNSURLSessionRequest {
//    NSString *strContent = myTextField.text;
    NSString *strUrl =@"http://www.cocoachina.com/";
    //中文字符串UTF-8转码
    
    NSURL *getUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    //2.创建请求对象 13     //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:getUrl];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //4.根据会话对象创建一个Task(发送请求）
    /*第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSString *strGetContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strGetContent);
        }
    }];
    //5.执行任务
    [dataTask resume];
}


//Post请求
-(void) postRequest {
    NSString *strContent = myTextField.text;
    NSString *strUrl =@"http://www.cocoachina.com/";



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
