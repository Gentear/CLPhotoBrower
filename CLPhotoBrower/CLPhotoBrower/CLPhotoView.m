//
//  CLPhotoView.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
//图片缩放比例
#define kMinZoomScale 1.0f
#define kMaxZoomScale 2.0f
#import "CLPhotoView.h"
#import "UIImageView+WebCache.h"
#import "CLProgressView.h"
#import "UIView+CLView.h"
@interface CLPhotoView()<UIScrollViewDelegate>
/**
 *  单击
 */
@property (strong,nonatomic) UITapGestureRecognizer *oneTap;
/**
 *  双击
 */
@property (strong,nonatomic) UITapGestureRecognizer *doubleTap;
@property (weak,nonatomic) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL hasLoadedImage;//图片下载成功为YES 否则为NO
/**
 *  进度条
 */
@property (strong,nonatomic) CLProgressView *progressView;
/**
 *  重新加载
 */
@property (weak,nonatomic) UIButton *reloadButton;
@end
@implementation CLPhotoView
#pragma mark - 懒加载
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.scrollView setZoomScale:1.0 animated:NO];
    if (_reloadButton) {
        [_reloadButton removeFromSuperview];
        _reloadButton = nil;
    }
    self.progressView.progress = 0;
    __weak typeof(self) weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.progressView.progress = (float)receivedSize/(float)expectedSize ;
        NSLog(@"%f",strongSelf.progressView.progress);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong typeof(self) strongSelf = weakSelf;
        [_progressView removeFromSuperview];
        _progressView = nil;
        if (error != nil){
            [strongSelf reloadButton];
        }
        strongSelf.hasLoadedImage = YES;
    }];
}
- (UIButton *)reloadButton{
    if (_reloadButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 2;
        button.clipsToBounds = YES;
        button.bounds = CGRectMake(0, 0, 200, 40);
        button.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.5);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.300];
        [button setTitle:@"原图加载失败，点击重新加载" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reloadImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _reloadButton = button;
        
    }
    return _reloadButton;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = ScreenBounds;
        scrollView.delegate = self;
        scrollView.clipsToBounds = YES;
        scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        scrollView.minimumZoomScale=kMinZoomScale;
        scrollView.maximumZoomScale=kMaxZoomScale;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return _scrollView;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}
- (UITapGestureRecognizer *)oneTap{
    if (_oneTap == nil) {
        _oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneTap:)];
        _oneTap.numberOfTapsRequired = 1;
        _oneTap.numberOfTouchesRequired = 1;
        //只能有一个手势存在
        [_oneTap requireGestureRecognizerToFail:self.doubleTap];
        
    }
    return _oneTap;
}
- (UITapGestureRecognizer *)doubleTap{
    if (_doubleTap == nil) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired  =1;
    }
    return _doubleTap;
}
- (CLProgressView *)progressView{
    if (_progressView == nil) {
        CLProgressView *progress = [CLProgressView progressView];
        [self addSubview:progress];
        _progressView = progress;
    }
    return _progressView;
}

#pragma mark - 点击方法
- (void)reloadImage
{
    self.imageUrl = _imageUrl;
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer{
    //图片加载完之后才能响应双击放大
    if (!self.hasLoadedImage) {
        return;
    }
    if (self.scrollView.zoomScale <= 1) {
        CGPoint pointInView = [recognizer locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.zoomScale * 2.0f;
        newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
        CGSize scrollViewSize = self.scrollView.bounds.size;
        CGFloat w = scrollViewSize.width / newZoomScale;
        CGFloat h = scrollViewSize.height / newZoomScale;
        CGFloat x = pointInView.x - (w / 2.0f);
        CGFloat y = pointInView.y - (h / 2.0f);
        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
        [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    }else{
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}
- (void)handleOneTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(hiddenWhenTouch)]) {
        [self.delegate hiddenWhenTouch];
    }
}
#pragma mark - 添加到父视图上
- (void)MoveToSuperview{
    self.backgroundColor = [UIColor blackColor];
    [self scrollView];
    [self addGestureRecognizer:self.oneTap];
    [self addGestureRecognizer:self.doubleTap];
}
#pragma mark - UIScrollViewDelegate
#pragma mark 缩放
/**
 *  缩放结束时调用
 *
 *  @param scrollView <#scrollView description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"开始缩放");
    return self.imageView;
}
/**
 *  缩放过程中调用
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageView.center = [self centerOfScrollViewContent:self.scrollView];
}
#pragma mark - 调整
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustFrames];
}

- (void)adjustFrames
{
    CGRect frame = self.scrollView.frame;
    if (self.imageView.image) {
        CGSize imageSize = self.imageView.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (YES) {
            CGFloat ratio = frame.size.width/imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height*ratio;
            imageFrame.size.width = frame.size.width;
        }
//        else{
//            if (frame.size.width <= frame.size.height) {
//                
//                CGFloat ratio = frame.size.width/imageFrame.size.width;
//                imageFrame.size.height = imageFrame.size.height*ratio;
//                imageFrame.size.width = frame.size.width;
//            }else{
//                CGFloat ratio = frame.size.height/imageFrame.size.height;
//                imageFrame.size.width = imageFrame.size.width*ratio;
//                imageFrame.size.height = frame.size.height;
//            }
//        }
        
        self.imageView.frame = imageFrame;
        self.scrollView.contentSize = self.imageView.frame.size;
        self.imageView.center = [self centerOfScrollViewContent:self.scrollView];
        
        
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        maxScale = maxScale>kMaxZoomScale?maxScale:kMaxZoomScale;
        
        self.scrollView.minimumZoomScale = kMinZoomScale;
        self.scrollView.maximumZoomScale = maxScale;
        self.scrollView.zoomScale = 1.0f;
    }else{
        frame.origin = CGPointZero;
        self.imageView.frame = frame;
        self.scrollView.contentSize = self.imageView.frame.size;
    }
    self.scrollView.contentOffset = CGPointZero;
    
}
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}
@end



