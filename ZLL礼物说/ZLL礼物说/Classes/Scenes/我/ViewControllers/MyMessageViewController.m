//
//  MyMessageViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "MyMessageViewController.h"
#import "LoginViewController.h"
@interface MyMessageViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIButton *userName;

@property (nonatomic, strong) FMDatabase *db;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *cancellUser;


@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.bounces = NO;
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1"];
    
   //设置头像的显示形状
    self.userImage.layer.masksToBounds = YES;
    
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2.0;
    
    NSLog(@"%f",self.userImage.frame.size.width/2.0);
    
    self.userImage.userInteractionEnabled = YES;
    
    //实现注销事件
    [self.cancellUser addTarget:self action:@selector(cancellUserOK) forControlEvents:UIControlEventTouchUpInside];
   
    //设置本地数据库
    [self settingDataBasic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = @[@"我的收藏",@"内存清除",@"给我们的建议"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:250/256.0 green:181/256.0 blue:242/256.0 alpha:1];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];

     NSString *cacheSize = [NSString stringWithFormat:@"清除缓存%ldM",size/1024/1024];
//    NSLog(@"%@",cacheSize);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:cacheSize preferredStyle:UIAlertControllerStyleAlert];
        
        [self showDetailViewController:alert sender:nil];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:action];
    }
}
#pragma mark -- 设置注销事件
- (void)cancellUserOK{
    
    [AVUser logOut];
    
    self.userImage.image = [UIImage imageNamed:@"dengru.png"];
    
    [self.userName setTitle:@"未登入" forState:UIControlStateNormal];
    
    [self userMessageHandle];

}

#pragma mark -- 设置本地数据库
- (void)settingDataBasic{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
      NSString *path = [documentPath stringByAppendingString:@"/data.sqlite"];
    //创建数据库
    self.db = [FMDatabase databaseWithPath:path];
    
    //打开数据库
    if ([self.db open]) {
        
        //创建表
        [self.db executeUpdate:@"create table if not exists MyImage (UserName text, Image blob)"];
        
    }else {
        
        NSLog(@"打开失败");
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    
     NSString *cacheSize = [NSString stringWithFormat:@"清除缓存%ldM",size/1024/1024];
    NSLog(@"%@",cacheSize);
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self userMessageHandle];
    
     //数据库保存图片
    AVUser *currentUser = [AVUser currentUser];

    FMResultSet *rb = [self.db executeQuery:@"select *from MyImage where UserName = ?",currentUser.username];
     if (rb.next) {
       
        NSData *data = [rb dataForColumn:@"Image"];
         
         self.userImage.image = [UIImage imageWithData:data];
    }
    
 
}

-(void)userMessageHandle{
    
 
    
    AVUser *currentUser = [AVUser currentUser];
   
    if (currentUser != nil) {
        
        // 允许用户使用应用
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginHandle)];
        
        [self.userImage addGestureRecognizer:pan];
        
        [self.userName addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
        
        //按钮的文字设置
        [self.userName setTitle:currentUser.username forState:UIControlStateNormal];
        
        //注销按钮出现
        self.cancellUser.hidden = NO;
        
        //取消按钮的互动
        self.userName.userInteractionEnabled = NO;
        
    } else {
        
        //开启按钮的互动
        self.userName.userInteractionEnabled = YES;
        
        //右上角是否有注销
        self.cancellUser.hidden = YES;

        //缓存用户对象为空时，可打开用户注册界面

        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginGifts)];
        
        [self.userImage addGestureRecognizer:pan];
        
        [self.userName addTarget:self action:@selector(loginGifts) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//未登入设置
- (void)loginGifts{
    
    
    LoginViewController *loginVC =[[ LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    nav.navigationBar.barTintColor = [UIColor redColor];
    
    loginVC.navigationItem.title = @"登入";
    
    [self showDetailViewController:nav sender:nil];
    
    
}

//登入设置
- (void)loginHandle{
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    
        [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.userImage.image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImagePNGRepresentation(self.userImage.image);
    
    AVUser *currentUser = [AVUser currentUser];
    
    FMResultSet *rb = [self.db executeQuery:@"select *from MyImage where UserName = ?;",currentUser.username];
  
    if (rb.next) {
        
        [self.db executeUpdate:@"update MyImage set Image = ? where UserName = ?;",data,currentUser.username];
    }else{

    [self.db executeUpdate:@"insert into MyImage (UserName, Image) values (?, ?);",currentUser.username,data];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
