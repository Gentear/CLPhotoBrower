//
//  CLPhotoView.h
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLPhotoViewDelegate <NSObject>

- (void)hiddenWhenTouch;

@end

@interface CLPhotoView : UICollectionViewCell
@property (strong,nonatomic) NSString *imageUrl;
@property (weak,nonatomic) UIImageView *imageView;
@property (strong, nonatomic) id<CLPhotoViewDelegate>delegate;
- (void)MoveToSuperview;
@end

