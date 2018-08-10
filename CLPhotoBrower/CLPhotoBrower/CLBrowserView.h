//
//  CLPhotoBrowser.h
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CLBrowserView : UIView
/** 照片数组 url请传入这个 */
@property (strong,nonatomic) NSMutableArray <NSString *> *photoUrlArr;
/** 所有的占位图 */
@property (strong,nonatomic) NSMutableArray <NSString *> *PhotoPlaceArr;

/** 照片数组 照片请传入这个*/
@property (strong,nonatomic) NSMutableArray <UIImage *> *photoArr;

/** 点击的图片位置 */
@property (assign,nonatomic) NSInteger indexPhoto;

/** 所有的imageView */
@property (strong,nonatomic) NSMutableArray <UIImageView *> *tapViewArr;


+ (id)PhotoBrowser;

- (void)show;
@end
