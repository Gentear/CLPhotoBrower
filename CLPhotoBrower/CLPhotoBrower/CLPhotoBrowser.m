//
//  CLPhotoBrowser.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#import "CLPhotoBrowser.h"
#import "CLPhotoView.h"
#import "UICollectionViewCell+CreatCell.h"
#import "CLPhotoFlowLayout.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface CLPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,CLPhotoViewDelegate>
/** collectionView */

@property (strong,nonatomic) UICollectionView *collectionView;
/** saveButton */

@property (strong,nonatomic) UIButton *saveButton;

/** indexLabel */

@property (strong,nonatomic) UILabel *indexLabel;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CLPhotoBrowser
+ (id)PhotoBrowser{
    return  [[self alloc]init];
}
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark 添加操作按钮
- (void)addToolbars
{
    //序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont systemFontOfSize:14];
    indexLabel.frame = CGRectMake(20, ScreenHeight - 45, 55, 30);

    if (self.PhotoArr.count > 0) {
        indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.PhotoArr.count];
        _indexLabel = indexLabel;
        [self addSubview:indexLabel];
    }
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] init];
    saveButton.frame = CGRectMake(ScreenWidth- 70, ScreenHeight - 45, 55, 30);
    saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    _saveButton = saveButton;
    [self addSubview:saveButton];
}

#pragma mark 保存图像
- (void)saveImage
{
    int index = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    
    CLPhotoView *cell = (CLPhotoView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
//    //获取权限
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
//    {
//        // 第一次安装App，还未确定权限，调用这里
//        if ([YFKit isPhotoAlbumNotDetermined])
//        {
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//            {
//                // 该API从iOS8.0开始支持
//                // 系统弹出授权对话框
//                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
//                        {
//                            // 用户拒绝，跳转到自定义提示页面
//                            DeniedAuthViewController *vc = [[DeniedAuthViewController alloc] init];
//                            [self presentViewController:vc animated:YES completion:nil];
//                        }
//                        else if (status == PHAuthorizationStatusAuthorized)
//                        {
//                            // 用户授权，弹出相册对话框
//                            [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
//                        }
//                    });
//                }];
//            }
//            else
//            {
//                // 以上requestAuthorization接口只支持8.0以上，如果App支持7.0及以下，就只能调用这里。
////                [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
//            }
//        }
//        else if ([YFKit isPhotoAlbumDenied])
//        {
//            // 如果已经拒绝，则弹出对话框
////            [self showAlertController:@"提示" message:@"拒绝访问相册，可去设置隐私里开启"];
//        }
//        else
//        {
//            // 已经授权，跳转到相册页面
////            [self presentToImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
//        }
//    }
//    else
//    {
//        // 当前设备不支持打开相册
////        [self showAlertController:@"提示" message:@"当前设备不支持相册"];
//    }
//
    
    UIImageWriteToSavedPhotosAlbum(cell.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
//    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//    indicator.center = self.center;
//    _indicatorView = indicator;
//    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
//    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.50f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 60);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:21];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = @"保存失败";
    }   else {
        label.text = @"保存成功";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}
#pragma mark - 懒加载
- (void)setPhotoArr:(NSMutableArray *)PhotoArr{
    _PhotoArr = PhotoArr;
    [self.collectionView reloadData];
    [self addToolbars];
}
- (void)setPhotoPlaceArr:(NSMutableArray<NSString *> *)PhotoPlaceArr{
    _PhotoPlaceArr = PhotoPlaceArr;
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        CLPhotoFlowLayout *flowLayout = [[CLPhotoFlowLayout alloc]init];
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth + 20, ScreenHeight) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height);
        [self addSubview:effectView];
        [self addSubview:collectionView];

        _collectionView = collectionView;
    }
    return _collectionView;
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1,(long)self.PhotoArr.count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.PhotoArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLPhotoView *cell = [CLPhotoView cellWithcollection:collectionView withIndex:indexPath];
    [cell MoveToSuperview];
    cell.delegate = self;
    cell.placeImageUrl = self.PhotoPlaceArr[indexPath.row];
    cell.imageUrl = self.PhotoArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self removeFromSuperview];
}
#pragma mark - CLPhotoViewDelegate
- (void)hiddenWhenTouch{
    [self hidden];
}
#pragma mark - show
- (void)show{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    self.collectionView.alpha = 0;
    UIImageView *tapView = self.tapViewArr[self.indexPhoto - 1];
    [self.collectionView setContentOffset:CGPointMake((self.indexPhoto - 1) * (ScreenWidth + 20), 0) animated:NO];
    CGRect rect = [tapView convertRect:tapView.bounds toView:nil];
//    rect = CGRectMake(self.tapView.frame.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.frame = rect;
    tempView.image = tapView.image;
    [self addSubview:tempView];
    tempView.contentMode = UIViewContentModeScaleAspectFit;
    [UIView animateWithDuration:0.25 animations:^{
        tempView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        self.collectionView.alpha = 1;
    }];
}
- (void)hidden{
    self.collectionView.alpha = 0;
    NSInteger currentPage = (NSInteger)self.collectionView.contentOffset.x/(ScreenWidth + 20);
    CLPhotoView *cell = (CLPhotoView *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:0]];
    UIImageView *tapView = self.tapViewArr[currentPage];
    CGRect rect = [tapView convertRect:tapView.bounds toView:nil];
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.frame = cell.imageView.frame;
    tempView.image = cell.imageView.image;
    if (rect.size.width == 0) {
        rect = CGRectMake(ScreenWidth/2, ScreenHeight/2, 0, 0);
    }
    [self addSubview:tempView];
    tempView.contentMode = UIViewContentModeScaleAspectFit;
    [UIView animateWithDuration:0.25 animations:^{
        tempView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{

    self.frame = newSuperview.frame;
}
@end
