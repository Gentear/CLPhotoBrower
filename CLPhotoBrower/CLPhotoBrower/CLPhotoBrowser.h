//
//  CLPhotoBrowser.h
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CLPhotoBrowser : UIView
/** 照片数组 */
@property (strong,nonatomic) NSMutableArray <NSString *> *PhotoArr;

/** 点击的图片位置 */
@property (assign,nonatomic) NSInteger indexPhoto;

/** 所有的imageView */
@property (strong,nonatomic) NSMutableArray <UIImageView *> *tapViewArr;

+ (id)PhotoBrowser;

- (void)show;
@end
