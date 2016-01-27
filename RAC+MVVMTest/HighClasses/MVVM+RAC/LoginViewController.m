//
//  LoginViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
/* 需求：1.监听两个文本框的内容，有内容才允许按钮点击
 2.默认登录请求.
 
 用MVVM：实现，之前界面的所有业务逻辑
 分析：1.之前界面的所有业务逻辑都交给控制器做处理
 2.在MVVM架构中把控制器的业务全部搬去VM模型，也就是每个控制器对应一个VM模型.
 
 步骤：1.创建LoginViewModel类，处理登录界面业务逻辑.
 2.这个类里面应该保存着账号的信息，创建一个账号Account模型
 3.LoginViewModel应该保存着账号信息Account模型。
 4.需要时刻监听Account模型中的账号和密码的改变，怎么监听？
 5.在非RAC开发中，都是习惯赋值，在RAC开发中，需要改变开发思维，由赋值转变为绑定，可以在一开始初始化的时候，就给Account模型中的属性绑定，并不需要重写set方法。
 6.每次Account模型的值改变，就需要判断按钮能否点击，在VM模型中做处理，给外界提供一个能否点击按钮的信号.
 7.这个登录信号需要判断Account中账号和密码是否有值，用KVO监听这两个值的改变，把他们聚合成登录信号.
 8.监听按钮的点击，由VM处理，应该给VM声明一个RACCommand，专门处理登录业务逻辑.
 9.执行命令，把数据包装成信号传递出去
 10.监听命令中信号的数据传递
 11.监听命令的执行时刻
 */

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "ListTableViewController.h"
#import "FlatButton.h"
#import "UIColor+Theme.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@property (weak, nonatomic)  UITextField *userNameTF;
@property (weak, nonatomic)  UITextField *pwdTF;
@property (weak, nonatomic)  UIButton *loginBtn;
@end

@implementation LoginViewController

- (LoginViewModel *)loginViewModel
{
    if (_loginViewModel == nil) {
        
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *userleftImageView = [UIImageView new];
    userleftImageView.image = [UIImage imageNamed:@"icon_user"];
    userleftImageView.frame = CGRectMake(5, 0, 18, 18);
    
    UITextField *userTextField = [UITextField new];
    userTextField.backgroundColor = [UIColor lightGrayColor];
    userTextField.layer.borderWidth = 1;
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSAttributedString * attributedStr = [[NSAttributedString alloc] initWithString:@"用户名" attributes:attributes];
    
    userTextField.attributedPlaceholder = attributedStr;
    userTextField.leftViewMode = UITextFieldViewModeAlways;
    userTextField.leftView = userleftImageView;
    
    [self.view addSubview:userTextField];
    [userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(@20);
        make.height.equalTo(@44);
    }];
    self.userNameTF = userTextField;
    
    UIImageView *pwdleftImageView = [UIImageView new];
    pwdleftImageView.image = [UIImage imageNamed:@"icon_password"];
    pwdleftImageView.frame = CGRectMake(0, 0, 18, 18);
    
    NSDictionary *pwdAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSAttributedString * pwdAttributedStr = [[NSAttributedString alloc] initWithString:@"密码" attributes:pwdAttributes];
    
    UITextField *pwdTextField = [UITextField new];
    pwdTextField.backgroundColor = [UIColor lightGrayColor];
    pwdTextField.attributedPlaceholder = pwdAttributedStr;
    pwdTextField.layer.borderWidth = 1;
    pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField.leftView = pwdleftImageView;

    [self.view addSubview:pwdTextField];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userTextField.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
        make.left.equalTo(@20);
        make.height.equalTo(@44);
    }];
    
    self.pwdTF = pwdTextField;
    
    FlatButton *btn = [FlatButton button];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor customBlueColor];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pwdTextField.mas_bottom).offset(10);
        make.leading.mas_equalTo(pwdTextField.mas_leading);
        make.centerX.mas_equalTo(self.view);
        make.height.equalTo(@40);
    }];
    self.loginBtn = btn;
    
    [self bindModel];
    
    
    // Do any additional setup after loading the view.
}

// 视图模型绑定
- (void)bindModel
{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account, account) = _userNameTF.rac_textSignal;
    RAC(self.loginViewModel.account, pwd) = _pwdTF.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ListTableViewController *listVC = [[ListTableViewController alloc] init];
            [self.navigationController pushViewController:listVC animated:YES];
        });
        
        
    }];
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
