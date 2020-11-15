//
//  MineViewController.m
//  Demo
//
//  Created by zhanghang on 2020/11/15.
//

#import "MineViewController.h"

@interface MineViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIScrollView *scroller;

/*
 * 个人图片
 */
@property(nonatomic,strong)UIImageView *headImageView;
/*
 * 个人信息视图
 */
@property(nonatomic,strong)UIView *infoView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}

- (void)setupView
{
    [self.view addSubview:self.scroller];
    [self.scroller addSubview:self.headImageView];
    [self setNavigationView];
    [self setPersonInfoView];
}

#pragma mark - 设置头部信息
- (void)setNavigationView
{
    CGFloat statusHeight = [self isIphoneX]?44:20;
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, statusHeight + 44)];
    statusView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:statusView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, statusHeight, [UIScreen mainScreen].bounds.size.width, 44)];
    titleLab.text = @"昵称";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [statusView addSubview:titleLab];
}


#pragma  mark - 个人消息
-(void)setPersonInfoView
{
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.scroller.frame) - 280)];
    infoView.backgroundColor = [UIColor whiteColor];
    self.infoView = infoView;
    [self.scroller addSubview:self.infoView];
    
    UIView *signView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, 60)];
    signView.backgroundColor = [UIColor lightGrayColor];
    [infoView addSubview:signView];
    UILabel *signTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20)];
    signTitle.text = @"签名";
    signTitle.textColor = [UIColor blackColor];
    signTitle.font = [UIFont systemFontOfSize:18];
    signTitle.textAlignment = NSTextAlignmentCenter;
    [signView addSubview:signTitle];
    
    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(signView.frame) + 15, [UIScreen mainScreen].bounds.size.width, 200)];
    tagView.backgroundColor = [UIColor lightGrayColor];
    [infoView addSubview:tagView];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 60)/3.0;
    NSArray *tagArr = @[@"关注",@"娱乐",@"科技",@"股票",@"推荐",@"财经",@"健康",@"社会",@"游戏"];
    for (NSInteger i=0; i<9; i++) {
        UILabel *tagLab = [[UILabel alloc]initWithFrame:CGRectMake(15 + (width + 15)*(i%3), 15 + 60*(i/3), width, 44)];
        tagLab.text = tagArr[i];
        tagLab.textColor = [UIColor blackColor];
        tagLab.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        tagLab.layer.cornerRadius = 22;
        tagLab.layer.masksToBounds = true;
        tagLab.textAlignment = NSTextAlignmentCenter;
        [tagView addSubview:tagLab];
    }
    self.scroller.contentSize = CGSizeMake(0, CGRectGetMidX(tagView.frame) + CGRectGetHeight(tagView.frame));
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}


#pragma mark - 更换图片
- (void)changePhoto
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:imagePicker animated:true completion:nil];
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.modalPresentationStyle = UIModalPresentationFullScreen;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        [self presentViewController:pickerImage animated:true completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

/*
 * 判断是否是刘海屏手机
 */
- (BOOL)isIphoneX {
    BOOL isIphoneX = false;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return isIphoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.bottom > 0.0) {
            isIphoneX = true;
        }
    }
    return  isIphoneX;
}

#pragma  scrollerViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.headImageView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    //图片上下偏移量
//    CGFloat imageOffsetY = _scroller.contentOffset.y;
//
//    //上滑
//    if (imageOffsetY < 0) {
//        // 高度宽度同时拉伸 从中心放大
//        CGFloat imgH = 280 - scrollView.contentOffset.y * 2;
//        CGFloat imgW = imgH * ([UIScreen mainScreen].bounds.size.width / 280);
//        self.headImageView.frame = CGRectMake(scrollView.contentOffset.y * ([UIScreen mainScreen].bounds.size.width / 280),0, imgW,imgH);
//
//
//    } else {
//        //只拉伸高度
//        self.headImageView.frame = CGRectMake(0,0, self.headImageView.frame.size.width,280-imageOffsetY);
//    }
//    self.infoView.frame = CGRectMake(0, CGRectGetMaxY(self.headImageView.frame), CGRectGetWidth(self.infoView.frame), CGRectGetHeight(self.infoView.frame));
}

#pragma mark - UIImagePickerControllerDelegate, UINavigationControllerDelegate
// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:true completion:nil];
        
        //加在视图中
        self.headImageView.image = image;
    }
}
// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}


#pragma  mark - lazy
- (UIScrollView *)scroller
{
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49)];
        _scroller.showsVerticalScrollIndicator = false;
        //设置代理scrollview的代理对象
        _scroller.delegate=self;
        _scroller.alwaysBounceVertical = YES;
        //        _scroller.minimumZoomScale = 0.5;
        //        _scroller.maximumZoomScale = 2.0;
        _scroller.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _scroller;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280)];
        _headImageView.backgroundColor = [UIColor yellowColor];
        _headImageView.image = [UIImage imageNamed:@"ok.jpg"];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
        _headImageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhoto)];
        [_headImageView addGestureRecognizer:tap];
    }
    return  _headImageView;
}
@end
