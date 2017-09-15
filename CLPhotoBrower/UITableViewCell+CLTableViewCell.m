//
//  UITableViewCell+CLTableViewCell.m
//  XMPP
//
//  Created by zyyt on 16/12/22.
//  Copyright © 2016年 conglei. All rights reserved.
//

#import "UITableViewCell+CLTableViewCell.h"

@implementation UITableViewCell (CLTableViewCell)
+(id)CL_cellWithNibNORepeatTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    NSString * className = NSStringFromClass([self class]);
    id cell = [[NSClassFromString(className) alloc] init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil];
        ;
        cell = [nibs lastObject];
    }
    return cell;
}
+(id)CL_cellWithNORepeatTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    
    NSString * className = NSStringFromClass([self class]);
    id cell = [[NSClassFromString(className) alloc] init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}
+ (id)CL_cellWithTableView:(UITableView*)tableView{
    
    NSString * className = NSStringFromClass([self class]);
    
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}
+(id)CL_cellWithNibTableView:(UITableView *)tableView
{
    NSString * className = NSStringFromClass([self class]);
    if (tableView.visibleCells.count == 0) {
        UINib * nib = [UINib nibWithNibName:className bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:className];
    }else
        if (![[[tableView valueForKey:@"_nibMap"] allKeys] containsObject:className]) {
            UINib * nib = [UINib nibWithNibName:className bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:className];
        }
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
}

@end
