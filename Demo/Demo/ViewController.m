//
//  ViewController.m
//  Demo
//
//  Created by zhanghang on 2020/11/15.
//


#import "ViewController.h"
#import "MainTabController.h"
@interface ViewController ()
/*
 *账号
 */
@property(nonatomic,strong)UITextField *phoneTextField;
/*
 *密码
 */
@property(nonatomic,strong)UITextField *passwTextField;

/*
 *登陆按钮
 */
@property(nonatomic,strong)UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)setupView
{
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwTextField];
    [self.view addSubview:self.loginBtn];
}


/*
 *登陆点击事件
 */
- (void)clickLogin
{
    [self.view endEditing:true];
    if (@available(iOS 13.0,*)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                UIWindow *window = windowScene.windows.firstObject;
                window.rootViewController = [MainTabController new];
            }
        }
    }else{
        [UIApplication sharedApplication].windows.firstObject.rootViewController = [MainTabController new];
    }
}

/*
 * 监测输入框长度
 */
- (void)textFieldChanged:(UITextField *)textField
{
    if (self.passwTextField.text.length && self.phoneTextField.text.length) {
        self.loginBtn.enabled = true;
        self.loginBtn.backgroundColor = [UIColor blueColor];
    }else{
        self.loginBtn.enabled = false;
        self.loginBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

/*
 * 收起键盘
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

#pragma mark -lazy
- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, [UIScreen mainScreen].bounds.size.height/2.0 - 120, [UIScreen mainScreen].bounds.size.width - 60, 44)];
        _phoneTextField.placeholder = @"请输入账号";
        _phoneTextField.textColor = [UIColor blackColor];
        _phoneTextField.font = [UIFont systemFontOfSize:16];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        [_phoneTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return  _phoneTextField;
}

- (UITextField *)passwTextField
{
    if (!_passwTextField) {
        _passwTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_phoneTextField.frame) +20, [UIScreen mainScreen].bounds.size.width - 60, 44)];
        _passwTextField.placeholder = @"请输入密码";
        _passwTextField.textColor = [UIColor blackColor];
        _passwTextField.font = [UIFont systemFontOfSize:16];
        _passwTextField.borderStyle = UITextBorderStyleRoundedRect;
        [_passwTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return  _passwTextField;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 120)/2.0, CGRectGetMaxY(_passwTextField.frame) + 50, 120, 50)];
        _loginBtn.enabled = false;
        _loginBtn.layer.cornerRadius = 5;
        _loginBtn.layer.masksToBounds = true;
        _loginBtn.backgroundColor = [UIColor lightGrayColor];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _loginBtn;;
}
@end
