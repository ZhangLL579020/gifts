//
//  LoginViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
- (IBAction)loginOK:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *pwd;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerView)];
}

- (void)registerView{
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
    
    nav.navigationBar.barTintColor = [UIColor redColor];
    
    registerVC.navigationItem.title = @"注册";
    
    registerVC.navigationController.navigationBar.translucent = NO;
    
    [self showDetailViewController:nav sender:nil];
   
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginOK:(id)sender {
    
    [AVUser logInWithUsernameInBackground:self.userName.text    password:self.pwd.text block:^(AVUser *user, NSError *error) {
        
        if (user != nil) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            
            NSLog(@"%@",error);
        }
    }];
    
}
@end
