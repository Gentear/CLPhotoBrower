//
//  CLProgressView.h
//  CLPhotoBrower
//
//  Created by zyyt on 16/5/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    CLLoopDiagram,//环
    CLPieDiagram,//圈
}CLProgressType;
@interface CLProgressView : UIView
@property (assign,nonatomic) CGFloat progress;
@property (assign,nonatomic) int progressType;

+ (id)progressView;
@end
