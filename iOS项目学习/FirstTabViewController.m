//
//  FirstTabViewController.m
//  iOS项目学习
//
//  Created by valenty on 16/2/13.
//  Copyright © 2016年 valenty. All rights reserved.
//

#import "FirstTabViewController.h"
#import "FirstTabFirstViewController.h"
#import "Person.h"
#import "Author.h"

@interface FirstTabViewController () {
    UIScrollView *scrollViewBg;
    UILabel *lblCatalog;
    
    UILabel *lblTips;
    UITextField *txtPlistUserName;
    UITextField *txtPlistAage;
    UITextField *txtPlistPhone;
    UIImageView *imgPlistUserView;
}

@end

@implementation FirstTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个页面" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    scrollViewBg = [[UIScrollView alloc] initWithFrame:[self.view bounds]];
    scrollViewBg.backgroundColor = [UIColor grayColor];
//    [scrollViewBg addTarget:self action:@selector(hideKeybord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scrollViewBg];
    
    [self buildSandBoxUI];
    [self buildPlistUI];
    [self loadArchiveData];
}

-(void) buildSandBoxUI {//沙盒目录
    lblCatalog = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 150, 12)];
    lblCatalog.text = @"02.获取沙盒目录";
    lblCatalog.font = [UIFont systemFontOfSize:12];
    [scrollViewBg addSubview:lblCatalog];
    
    // Override point for customization after application launch.
    NSString *strHomeDir = [NSString stringWithFormat:@"应用根目录：%@",NSHomeDirectory()];
    NSString *strDocumentDir = [NSString stringWithFormat:@"文档目录：%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
    NSString *strDocumentDir2 = [NSString stringWithFormat:@"文档目录2：%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];;
    NSString *strCachDir = [NSString stringWithFormat:@"缓存目录：%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]];
    NSString *strTempDir = [NSString stringWithFormat:@"临时目录：%@",NSTemporaryDirectory()];
    
    NSString *strDirContent = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",strHomeDir,strDocumentDir,strDocumentDir2,strCachDir,strTempDir];
    
    NSLog(@"%@",strDirContent);
}

-(void) buildPlistUI {//Plist文件写入
    lblTips = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lblCatalog.frame) + 20, 320, 50)];
    lblTips.text = @"03.Plist概念及演练，可保存：\nNSArray，NSDictionary，Boolean，NSDate，NSNumber，NSString";
    lblTips.font = [UIFont systemFontOfSize:12];
    lblTips.numberOfLines = 0;
    [scrollViewBg addSubview:lblTips];
    
    
    txtPlistUserName = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblTips.frame)+10, 200, 25)];
    txtPlistUserName.layer.borderColor  = [[UIColor darkGrayColor] CGColor];
    txtPlistUserName.layer.borderWidth = 1;
    txtPlistUserName.placeholder = @"姓名";
    txtPlistUserName.layer.cornerRadius = 3;
    [scrollViewBg  addSubview:txtPlistUserName];
    
    
    txtPlistAage = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(txtPlistUserName.frame)+10, 200, 25)];
    txtPlistAage.layer.borderColor  = [[UIColor darkGrayColor] CGColor];
    txtPlistAage.layer.borderWidth = 1;
    txtPlistAage.placeholder = @"年龄";
    txtPlistAage.layer.cornerRadius = 3;
    [scrollViewBg addSubview:txtPlistAage];
    
    
    txtPlistPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(txtPlistAage.frame)+10, 200, 25)];
    txtPlistPhone.layer.borderColor  = [[UIColor darkGrayColor] CGColor];
    txtPlistPhone.layer.borderWidth = 1;
    txtPlistPhone.placeholder = @"电话";
    txtPlistPhone.layer.cornerRadius = 3;
    [scrollViewBg addSubview:txtPlistPhone];
    
    
    imgPlistUserView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(txtPlistUserName.frame)+5, CGRectGetMinY(txtPlistUserName.frame), 100, 90)];
    imgPlistUserView.layer.borderWidth = 1;
    imgPlistUserView.layer.borderColor = [[UIColor redColor] CGColor];
    imgPlistUserView.contentMode = UIViewContentModeScaleAspectFill;
    imgPlistUserView.clipsToBounds = YES;
    imgPlistUserView.userInteractionEnabled = YES;
//    imgUserView.image = [UIImage imageNamed:@"plistPic"];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [imgPlistUserView addGestureRecognizer:singleTap];
    [scrollViewBg addSubview:imgPlistUserView];
    
    
    UIButton *btnPlistSaveData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgPlistUserView.frame)+10, 100, 25)];
    [btnPlistSaveData addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    btnPlistSaveData.backgroundColor = [UIColor redColor];
    btnPlistSaveData.titleLabel.font = [UIFont systemFontOfSize:12];
    btnPlistSaveData.layer.cornerRadius = 3;
    [btnPlistSaveData setTitle:@"保存Plist数据" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnPlistSaveData];
    
    
    UIButton *btnPlistReadData = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnPlistSaveData.frame) + 10, CGRectGetMaxY(imgPlistUserView.frame)+10, 100, 25)];
    [btnPlistReadData addTarget:self action:@selector(readData) forControlEvents:UIControlEventTouchUpInside];
    btnPlistReadData.backgroundColor = [UIColor darkGrayColor];
    btnPlistReadData.layer.cornerRadius = 3;
    btnPlistReadData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnPlistReadData setTitle:@"读取Plist数据" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnPlistReadData];
    
    
    UILabel *lblArhiveTips = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnPlistSaveData.frame)+10, 320, 20)];
    lblArhiveTips.text = @"04.归档和恢复归档，自定义对象需要实现NSCoding协议";
    lblArhiveTips.font = [UIFont systemFontOfSize:12];
    lblArhiveTips.numberOfLines = 0;
    [scrollViewBg addSubview:lblArhiveTips];
    
    
    UIButton *btnArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblArhiveTips.frame)+10, 100, 25)];
    [btnArchiveData addTarget:self action:@selector(archiveCustomObject) forControlEvents:UIControlEventTouchUpInside];
    btnArchiveData.backgroundColor = [UIColor redColor];
    btnArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    btnArchiveData.layer.cornerRadius = 3;
    [btnArchiveData setTitle:@"归档【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnArchiveData];
    
    
    UIButton *btnUnArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnArchiveData.frame) + 10, CGRectGetMaxY(lblArhiveTips.frame)+10, 100, 25)];
    [btnUnArchiveData addTarget:self action:@selector(unArchiveCustomObject) forControlEvents:UIControlEventTouchUpInside];
    btnUnArchiveData.backgroundColor = [UIColor darkGrayColor];
    btnUnArchiveData.layer.cornerRadius = 3;
    btnUnArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnUnArchiveData setTitle:@"解档【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnUnArchiveData];
    
    
    UILabel *lblMultiArhiveTips = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnUnArchiveData.frame)+10, 320, 20)];
    lblMultiArhiveTips.text = @"06.NSData归档多个对象【重点】";
    lblMultiArhiveTips.font = [UIFont systemFontOfSize:12];
    lblMultiArhiveTips.numberOfLines = 0;
    [scrollViewBg addSubview:lblMultiArhiveTips];
    
    
    UIButton *btnMultiArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblMultiArhiveTips.frame)+10, 130, 25)];
    [btnMultiArchiveData addTarget:self action:@selector(dataArchiveMultiPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    btnMultiArchiveData.backgroundColor = [UIColor redColor];
    btnMultiArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    btnMultiArchiveData.layer.cornerRadius = 3;
    [btnMultiArchiveData setTitle:@"Data归档多个【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnMultiArchiveData];
    
    
    UIButton *btnMultiUnArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnMultiArchiveData.frame) + 10, CGRectGetMaxY(lblMultiArhiveTips.frame)+10, 130, 25)];
    [btnMultiUnArchiveData addTarget:self action:@selector(dataUnArchiveMultiPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    btnMultiUnArchiveData.backgroundColor = [UIColor darkGrayColor];
    btnMultiUnArchiveData.layer.cornerRadius = 3;
    btnMultiUnArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnMultiUnArchiveData setTitle:@"Data解档多个【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnMultiUnArchiveData];
    
    
    UILabel *lblArrayArhiveTips = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnMultiUnArchiveData.frame)+10, 320, 20)];
    lblArrayArhiveTips.text = @"07.NSArray归档多个对象";
    lblArrayArhiveTips.font = [UIFont systemFontOfSize:12];
    lblArrayArhiveTips.numberOfLines = 0;
    [scrollViewBg addSubview:lblArrayArhiveTips];
    
    
    UIButton *btnArrayArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblArrayArhiveTips.frame)+10, 130, 25)];
    [btnArrayArchiveData addTarget:self action:@selector(arrayArchiveMultiPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    btnArrayArchiveData.backgroundColor = [UIColor redColor];
    btnArrayArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    btnArrayArchiveData.layer.cornerRadius = 3;
    [btnArrayArchiveData setTitle:@"Array归档多个【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnArrayArchiveData];
    
    
    UIButton *btnArrayUnArchiveData = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnArrayArchiveData.frame) + 10, CGRectGetMaxY(lblArrayArhiveTips.frame)+10, 130, 25)];
    [btnArrayUnArchiveData addTarget:self action:@selector(arrayUnArchiveMultiPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    btnArrayUnArchiveData.backgroundColor = [UIColor darkGrayColor];
    btnArrayUnArchiveData.layer.cornerRadius = 3;
    btnArrayUnArchiveData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnArrayUnArchiveData setTitle:@"Array解档多个【对象】" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnArrayUnArchiveData];
    
    
    UILabel *lblUsersDefaultTips = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnArrayUnArchiveData.frame)+10, 320, 20)];
    lblUsersDefaultTips.text = @"08.用户偏好设置【键值对，重要的信息，对时时同步要求性比较高的】";
    lblUsersDefaultTips.font = [UIFont systemFontOfSize:12];
    lblUsersDefaultTips.numberOfLines = 0;
    [scrollViewBg addSubview:lblUsersDefaultTips];
    
    
    UIButton *btnUserDefaultsData = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lblUsersDefaultTips.frame)+10, 130, 25)];
    [btnUserDefaultsData addTarget:self action:@selector(saveUerDefaults) forControlEvents:UIControlEventTouchUpInside];
    btnUserDefaultsData.backgroundColor = [UIColor redColor];
    btnUserDefaultsData.layer.cornerRadius = 3;
    btnUserDefaultsData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnUserDefaultsData setTitle:@"保存用户偏好设置" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnUserDefaultsData];
    
    
    UIButton *btnReadUserDefaltsData = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnUserDefaultsData.frame) + 10, CGRectGetMaxY(lblUsersDefaultTips.frame)+10, 130, 25)];
    [btnReadUserDefaltsData addTarget:self action:@selector(readUerDefaults) forControlEvents:UIControlEventTouchUpInside];
    btnReadUserDefaltsData.backgroundColor = [UIColor darkGrayColor];
    btnReadUserDefaltsData.layer.cornerRadius = 3;
    btnReadUserDefaltsData.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnReadUserDefaltsData setTitle:@"读取用户偏好设置" forState:UIControlStateNormal];
    [scrollViewBg addSubview:btnReadUserDefaltsData];
    
    
    [scrollViewBg setContentSize:CGSizeMake(self.view.bounds.size.width, 2500)];
}

-(void) hideKeybord {
    [scrollViewBg endEditing:YES];
}

-(void) saveData {
    [self hideKeybord];
    
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //保存array
    NSArray *arrayData = @[txtPlistUserName.text,txtPlistAage.text,txtPlistPhone.text];
    NSString *strArrayDataDir = [strDocumentDir stringByAppendingPathComponent:@"array.plist"];
    [arrayData writeToFile:strArrayDataDir atomically:YES];//atomically 生成临时文件，写入文件
    
    //保存dictionary 1
    NSString *strDictionaryDataPath = [strDocumentDir stringByAppendingPathComponent:@"dictionary.plist"];
    NSMutableDictionary *dictData = [NSMutableDictionary dictionary];
    [dictData setObject:txtPlistUserName.text forKey:@"userName"];
    [dictData setObject:txtPlistAage.text forKey:@"userAge"];
    [dictData setObject:txtPlistPhone.text forKey:@"userPhone"];
    [dictData writeToFile:strDictionaryDataPath atomically:YES];
    
    //保存dictionary 2
    NSArray *arrayDataName = @[@"姓名",@"年龄",@"手机号"];
    NSString *strDictDataPath = [strDocumentDir stringByAppendingPathComponent:@"dic.plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:arrayData forKeys:arrayDataName];
    if ([dict writeToFile:strDictDataPath atomically:YES]) {
        NSLog(@"dictionary 2 写入成功！");
    }
    
    //写入临时txt文件
    NSString *strTemporaryContent = @"sdfsdfsdfsdfsdf";
    NSString *strTemporaryContentPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"file.txt"];
    if ([strTemporaryContent writeToFile:strTemporaryContentPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"TemporaryContent 写入成功！");
    }
    
    //把图片写入cache
    UIImage *myImage =[UIImage imageNamed:@"plistPic"];// imgUserView.image;
    NSData *myImageData = UIImageJPEGRepresentation(myImage, 0.1);
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"myImageData.png"];
    if ([myImageData writeToFile:cacheDir atomically:YES]) {
        NSLog(@"图片 写入cache成功！");
    }
}

-(void) readData {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strDictDataPath = [strDocumentDir stringByAppendingPathComponent:@"dic.plist"];
    NSDictionary *dictData = [[NSDictionary alloc] initWithContentsOfFile:strDictDataPath];
    NSString *strName = dictData[@"姓名"];
    NSString *strAge = dictData[@"年龄"];
    NSString *strPhone =dictData[@"手机号"];
    txtPlistUserName.text = strName;
    txtPlistAage.text = strAge;
    txtPlistPhone.text = strPhone;
    
    //读取缓存中的图片
    NSString *strCacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *strPicName = [strCacheDir stringByAppendingPathComponent:@"myImageData.png"];
    imgPlistUserView.image = [UIImage imageWithContentsOfFile:strPicName];
}

-(void) nextPage {
    FirstTabFirstViewController *firstVC = [[FirstTabFirstViewController alloc] init];
    [self.navigationController pushViewController:firstVC animated:YES];
}


-(void) loadArchiveData {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strArchiveDataPath = [strDocumentDir stringByAppendingPathComponent:@"array.archive"];
    NSArray *myData = @[@"张三",@"李四",@"王五"];
    [NSKeyedArchiver archiveRootObject:myData toFile:strArchiveDataPath];//归档数组
    
    NSArray *unArchiveArrayData = [NSKeyedUnarchiver unarchiveObjectWithFile:strArchiveDataPath];//解档数组
    NSLog(@"%@",unArchiveArrayData);
}


-(void) archiveCustomObject {
    NSString *strArchiveDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strArchiveDataPath = [strArchiveDocumentDir stringByAppendingPathComponent:@"personInfo.plist"];
    
    Person *archivePerson = [Person initPersonWithName:txtPlistUserName.text andImage:[UIImage imageNamed:@"头像1"] andAge:txtPlistAage.text andPhone:txtPlistPhone.text];
    if ([NSKeyedArchiver archiveRootObject:archivePerson toFile:strArchiveDataPath]) {
        NSLog(@"-----对象归档成功-----");
    }
}

-(void) unArchiveCustomObject{
    NSString *strArchiveDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strArchiveDataPath = [strArchiveDocumentDir stringByAppendingPathComponent:@"personInfo.plist"];
    
    Person *unArchivePerson = [NSKeyedUnarchiver unarchiveObjectWithFile:strArchiveDataPath];
    txtPlistUserName.text = unArchivePerson.name;
    txtPlistAage.text = unArchivePerson.age;
    txtPlistPhone.text = unArchivePerson.phone;
    imgPlistUserView.image = unArchivePerson.userImage;
    
    NSLog(@"%@",[unArchivePerson description]);
}



- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == imgPlistUserView) {//点击事件接受方
        if (imgPlistUserView.tag == 1) {
            [imgPlistUserView setImage:[UIImage imageNamed:@"头像1"]];
            imgPlistUserView.tag = 2;
        } else {
            [imgPlistUserView setImage:[UIImage imageNamed:@"plistPic"]];
            imgPlistUserView.tag = 1;
        }
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];//获取所有的点击事件
    if ([touch view] == imgPlistUserView) {//点击事件接受方
        if (imgPlistUserView.tag == 1) {
            [imgPlistUserView setImage:[UIImage imageNamed:@"头像1"]];
            imgPlistUserView.tag = 2;
        } else {
            [imgPlistUserView setImage:[UIImage imageNamed:@"plistPic"]];
            imgPlistUserView.tag = 1;
        }
    }
}


//Data归档多个对象
-(void) dataArchiveMultiPersonInfo {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strPath = [strDocumentDir stringByAppendingPathComponent:@"multiPersonInfo.plist"];
    
    Person *person1 = [Person initPersonWithName:@"张三" andImage:[UIImage imageNamed:@"头像1"] andAge:@"20" andPhone:@"15985852013"];
    Person *person2 = [Person initPersonWithName:@"李四" andImage:[UIImage imageNamed:@"plistPic"] andAge:@"30" andPhone:@"15985852014"];
    
    //初始化可变数据区
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:person1 forKey:@"person1"];
    [archiver encodeObject:person2 forKey:@"person2"];
    [archiver finishEncoding];//归档完毕【一定要调用此方法】
    if ([data writeToFile:strPath atomically:YES]) {
        NSLog(@"多个对象归档成功！");
    }
}

//Data解档多个对象
-(void) dataUnArchiveMultiPersonInfo {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strFilePath = [strDocumentDir stringByAppendingPathComponent:@"multiPersonInfo.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:strFilePath];
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    NSKeyedUnarchiver *unArchiver = [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
    Person *person1 = [unArchiver decodeObjectForKey:@"person1"];
    Person *person2 = [unArchiver decodeObjectForKey:@"person2"];
    [unArchiver finishDecoding];//解档完毕【一定要调用此方法】
    
    NSLog(@"%@",[person1 description]);
    NSLog(@"%@",[person2 description]);
}

//Array归档多个对象
-(void) arrayArchiveMultiPersonInfo {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strFilePath = [strDocumentDir stringByAppendingPathComponent:@"archiveArray.plist"];
    Author *author1 = [Author initAuthorWithName:@"张三" andImage:[UIImage imageNamed:@"plistPic"] andAge:@"20" andPhone:@"15985852013" andBookName:@"书名1"];
    Author *author2 = [Author initAuthorWithName:@"李四" andImage:[UIImage imageNamed:@"plistPic"] andAge:@"30" andPhone:@"15985852014" andBookName:@"书名2"];
    NSArray *array = @[author1,author2];
    BOOL bArchiver = [NSKeyedArchiver archiveRootObject:array toFile:strFilePath];
    if (bArchiver) {
        NSLog(@"Array归档多个对象成功！");
    }
}
//Array解档多个对象
-(void) arrayUnArchiveMultiPersonInfo {
    NSString *strDocumentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *strFilePath = [strDocumentDir stringByAppendingPathComponent:@"archiveArray.plist"];
    NSArray *arrayData = [NSKeyedUnarchiver unarchiveObjectWithFile:strFilePath];////////////?????////////////////////////////////////////////////
    Author *person1 = arrayData[0];
    Author *person2 = arrayData[1];
    NSLog(@"%@",person1.name);
    NSLog(@"%@",person2.bookName);
}


//用户偏好设置
-(void) saveUerDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"sdfsdf" forKey:@"name"];
    [userDefaults setObject:@"0" forKey:@"isPurchase"];
    [userDefaults setObject:@"20" forKey:@"age"];
    if ([userDefaults synchronize]) { //立即同步
        NSLog(@"系统偏好设置同步成功！");
    }
}

-(void) readUerDefaults {
    NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSLog(@"%@",strName);
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
