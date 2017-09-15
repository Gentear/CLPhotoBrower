//
//  CLProgressView.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/5/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "CLProgressView.h"

@interface CLProgressView()
@property (strong,nonatomic) CAShapeLayer *shapeLayer;
@end
@implementation CLProgressView
+ (id)progressView{
    
    return [[self alloc]init];
    
}
- (instancetype)init{
    if (self = [super init]) {
        self.progressType = CLPieDiagram;
        self.frame = [UIScreen mainScreen].bounds;
        [self shapeLayer];
    }
    return self;
}
#pragma mark - 懒加载
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.shapeLayer.strokeEnd = progress ;
    if (progress == 0) {
        self.shapeLayer.strokeStart = 0;
        self.shapeLayer.strokeEnd = 0;
    }
    self.hidden = NO;
    if (progress == 1) {
    }
}
- (CAShapeLayer *)shapeLayer{
    if (_shapeLayer == nil) {
        _shapeLayer = [[CAShapeLayer alloc]init];
        _shapeLayer.frame = CGRectMake(0, 0, 50, 50);
        _shapeLayer.position = self.center;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 8.0f;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.transform = CATransform3DMakeRotation(-M_PI * 0.5, 0, 0, 1);
        UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 40, 40)];//画个圆
        _shapeLayer.path = bezier.CGPath;
        [self.layer addSublayer:_shapeLayer];
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 0;
    }
    return _shapeLayer;
}
@end
