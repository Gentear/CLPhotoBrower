//
//  UITableViewCell+CLTableViewCell.h
//  XMPP
//
//  Created by zyyt on 16/12/22.
//  Copyright © 2016年 conglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CLTableViewCell)
/**
 *  xib加载cell
 */
+ (id)CL_cellWithNibTableView:(UITableView *)tableView;
/**
 *  直接加载cell
 */
+ (id)CL_cellWithTableView:(UITableView*)tableView;
/**
 *  没有复用机制的cell
 */
+ (id)CL_cellWithNORepeatTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath;
/**
 *  没有复用机制的xib的cell
 */
+(id)CL_cellWithNibNORepeatTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath;
@end
