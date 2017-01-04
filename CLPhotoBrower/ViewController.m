//
//  ViewController.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/5/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "ViewController.h"
#import "CLPhotoBrowser.h"
#import "CLPhotoBrower/CLPhotoView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong,nonatomic) UITableView *tableView;
/**
 *UIScrollView
 */
@property(nonatomic,strong)UIScrollView *scrollView;

/**
 *  UIImageView
 */
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong) NSMutableArray *objects;

@end

@implementation ViewController

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.objects = [NSMutableArray array];
    
    [self.objects addObject:@[@"1.gif", @"http://image.tianjimedia.com/uploadImages/upload/20150818/2z2qe0dqi5xgif.gif"]];
    [self.objects addObject:@[@"2.gif", @"http://image.tianjimedia.com/uploadImages/upload/20150818/m2yoqll1by4gif.gif"]];
    [self.objects addObject:@[@"3.gif", @"http://image.tianjimedia.com/uploadImages/upload/20150818/3qmnrrtlvqbgif.gif"]];
    [self.objects addObject:@[@"4.gif", @"http://image.tianjimedia.com/uploadImages/upload/20150818/azgulan2yumgif.gif"]];
    [self.objects addObject:@[@"5.gif", @"http://image.tianjimedia.com/uploadImages/upload/20150818/ajiowjxkc0wgif.gif"]];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}


- (void)viewWillAppear:(BOOL)animated {
    [self tableView];
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
}

-(void) imageTapAction:(UITapGestureRecognizer *)tap
{
    NSMutableArray * photoViews = [NSMutableArray array];
    NSMutableArray * photoItems = [NSMutableArray array];

    [self.objects enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        [photoViews addObject:cell.imageView];
        [photoItems addObject:obj[1]];
    }];
    CLPhotoBrowser *photo = [CLPhotoBrowser PhotoBrowser];
    photo.tapViewArr = photoViews;
    photo.indexPhoto = tap.view.tag;
    photo.PhotoArr = photoItems;
    [photo show];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NSArray * object = self.objects[indexPath.row];
    cell.textLabel.text = object[1];
    cell.imageView.image = [UIImage imageNamed:object[0]];
    cell.imageView.tag = indexPath.row + 1;
    cell.imageView.userInteractionEnabled = YES;
    
    if (cell.imageView.gestureRecognizers.count) {
        [cell.imageView removeGestureRecognizer:cell.imageView.gestureRecognizers.firstObject];
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    [cell.imageView addGestureRecognizer:tap];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
@end
