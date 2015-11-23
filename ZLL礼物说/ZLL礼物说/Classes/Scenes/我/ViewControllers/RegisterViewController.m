//
//  RegisterViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *uerNameTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;
- (IBAction)registerOK:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)registerOK:(id)sender {
    
    
    AVUser *user = [AVUser user];
    
    user.username = self.uerNameTF.text;
    
    user.password = self.pwdTF.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //储存成功
        if (succeeded) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}
@end
