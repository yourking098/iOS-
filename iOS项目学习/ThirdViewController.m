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
    
    UILabel *lblCatalog = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 450, 150)];
    lblCatalog.text = @"网络传输请求步骤：\n 1、NSURL(地址)\n 2、NSURLRequest(Get请求)\n 3、NSMutableURLRequest(Post请求)\n 4、NSURLConnection(连接) \n NSRULConnectionDataDelegate常用的代理方法\n，处理请求返回的结果";
    lblCatalog.numberOfLines = 0;
    lblCatalog.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lblCatalog];
    
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblCatalog.frame) + 10, 300, 30)];
    myTextField.layer.borderWidth = 1;
    myTextField.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:myTextField];
    
    
    UIButton *btnNSURLConnectionGetRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(myTextField.frame)+20, 220, 25)];
    [btnNSURLConnectionGetRequest addTarget:self action:@selector(getRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLConnectionGetRequest.backgroundColor = [UIColor redColor];
    btnNSURLConnectionGetRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLConnectionGetRequest.layer.cornerRadius = 3;
    [btnNSURLConnectionGetRequest setTitle:@"NSURLConnection的GET同步请求" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLConnectionGetRequest];
    
    
    UIButton *btnNSURLSessionGetRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLConnectionGetRequest.frame)+10, 220, 25)];
    [btnNSURLSessionGetRequest addTarget:self action:@selector(getNSURLSessionRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLSessionGetRequest.backgroundColor = [UIColor redColor];
    btnNSURLSessionGetRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLSessionGetRequest.layer.cornerRadius = 3;
    [btnNSURLSessionGetRequest setTitle:@"NSURLSession的GET同步请求（推荐）" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLSessionGetRequest];
    
    
    UIButton *btnNSURLConnectionPostRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLSessionGetRequest.frame)+20, 220, 25)];
    [btnNSURLConnectionPostRequest addTarget:self action:@selector(postRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLConnectionPostRequest.backgroundColor = [UIColor redColor];
    btnNSURLConnectionPostRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLConnectionPostRequest.layer.cornerRadius = 3;
    [btnNSURLConnectionPostRequest setTitle:@"NSURLConnection的POST同步请求" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLConnectionPostRequest];
    
    
    UIButton *btnNSURLSessionPostRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLConnectionPostRequest.frame)+10, 230, 25)];
    [btnNSURLSessionPostRequest addTarget:self action:@selector(postNSURLSessionRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLSessionPostRequest.backgroundColor = [UIColor redColor];
    btnNSURLSessionPostRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLSessionPostRequest.layer.cornerRadius = 3;
    [btnNSURLSessionPostRequest setTitle:@"NSURLSession的POST同步请求（推荐）" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLSessionPostRequest];
    
    
    UIButton *btnNSURLConnectionSynPostRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLSessionPostRequest.frame)+20, 220, 25)];
    [btnNSURLConnectionSynPostRequest addTarget:self action:@selector(synPostRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLConnectionSynPostRequest.backgroundColor = [UIColor redColor];
    btnNSURLConnectionSynPostRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLConnectionSynPostRequest.layer.cornerRadius = 3;
    [btnNSURLConnectionSynPostRequest setTitle:@"NSURLConnection的POST异步请求" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLConnectionSynPostRequest];
    
    
    UIButton *btnNSURLSessionSynPostRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btnNSURLConnectionSynPostRequest.frame)+10, 230, 25)];
    [btnNSURLSessionSynPostRequest addTarget:self action:@selector(sessionSynPostRequest) forControlEvents:UIControlEventTouchUpInside];
    btnNSURLSessionSynPostRequest.backgroundColor = [UIColor redColor];
    btnNSURLSessionSynPostRequest.titleLabel.font = [UIFont systemFontOfSize:12];
    btnNSURLSessionSynPostRequest.layer.cornerRadius = 3;
    [btnNSURLSessionSynPostRequest setTitle:@"NSURLSession的POST异步请求（推荐）" forState:UIControlStateNormal];
    [self.view addSubview:btnNSURLSessionSynPostRequest];
    
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

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error description]);
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


-(NSMutableURLRequest *) loadPostRequest {
    NSString *strContent = myTextField.text;
    NSString *strUrl =@"http://www.kuaidi100.com/autonumber/autoComNum";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5.0];
    [request setHTTPMethod:@"POST"];
//    [request setCachePolicy:<#(NSURLRequestCachePolicy)#>];//缓存策略
    
    NSString *strBody = [NSString stringWithFormat:@"text=%@",@"783140295930"];
    //把参数转成UTF-8格式的Data
    NSData *bodyData = [strBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    return request;
}


//NSURLConnection的Post请求
-(void) postRequest {
    NSMutableURLRequest *request = [self loadPostRequest];
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//NSURLSession的Post请求
-(void) postNSURLSessionRequest {
    NSMutableURLRequest *request = [self loadPostRequest];
    NSURLSession *session = [NSURLSession sharedSession];
    //6.根据会话对象创建一个Task(发送请求）
    /*
     26      第一个参数：请求对象
     27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     28                 data：响应体信息（期望的数据）
     29                 response：响应头信息，主要是对服务器端的描述
     30                 error：错误信息，如果请求失败，则error有值
     31      */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"POST请求数据：%@",strData);
    }];
    
    //7.执行任务
    [dataTask resume];
}

//异步请求
-(void) synPostRequest {
    NSMutableURLRequest *request = [self loadPostRequest];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strData);
        }
    }];
}

//异步请求???????????
-(void) sessionSynPostRequest {
    NSMutableURLRequest *request = [self loadPostRequest];
    NSURLSession *session = [NSURLSession sharedSession];//初始化
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strData);
    }];
    // 使用resume方法启动任务
    [dataTask resume];
    
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
