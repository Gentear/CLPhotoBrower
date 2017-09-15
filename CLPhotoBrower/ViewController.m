//
//  ViewController.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/5/23.
//  Copyright © 2016年 zyyt. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define BarHeight 20
#define NVHeight 44
#define TBHeight 44

#define BackgroundColor [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1]
#import "ViewController.h"
#import "CLPhotoBrowser.h"
#import "CLPhotoBrower/CLPhotoView.h"
#import "UIImageView+WebCache.h"
#import "TestTableViewCell.h"
#import "UITableViewCell+CLTableViewCell.h"
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
    
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/3923406-1c7556e8fe4e20fe.jpg", @"http://upload-images.jianshu.io/upload_images/3923406-1c7556e8fe4e20fe.jpg"]];
    [self.objects addObject:@[@"http://upload-images.jianshu.io/upload_images/3459828-483ab1e7973134d4.jpg", @"http://upload-images.jianshu.io/upload_images/3459828-483ab1e7973134d4.jpg"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/635542-80c306bcfc8fa31f.jpg", @"http://upload-images.jianshu.io/upload_images/635542-80c306bcfc8fa31f.jpg"]];
    [self.objects addObject:@[@"http://upload-images.jianshu.io/upload_images/7663825-1235c66ee07f9fe9.jpg" , @"http://upload-images.jianshu.io/upload_images/7663825-1235c66ee07f9fe9.jpg"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/3343569-5f53f1faca0c06ed", @"http://upload-images.jianshu.io/upload_images/3343569-5f53f1faca0c06ed"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/31282-6b5c65b452d044c0.jpeg", @"http://upload-images.jianshu.io/upload_images/31282-6b5c65b452d044c0.jpeg"]];
    [self.objects addObject:@[@"http://upload-images.jianshu.io/upload_images/906620-4e58cc9263574cbb", @"http://upload-images.jianshu.io/upload_images/906620-4e58cc9263574cbb"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/1669869-f3cd7b65b67c3b6f.jpg", @"http://upload-images.jianshu.io/upload_images/1669869-f3cd7b65b67c3b6f.jpg"]];
    [self.objects addObject:@[@"http://upload-images.jianshu.io/upload_images/1522393-de81b72a1f42be3f.jpg" , @"http://upload-images.jianshu.io/upload_images/1522393-de81b72a1f42be3f.jpg"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/2812050-22d99ac201ed960a.JPG", @"http://upload-images.jianshu.io/upload_images/2812050-22d99ac201ed960a.JPG"]];
    [self.objects addObject:@[ @"http://upload-images.jianshu.io/upload_images/1896623-b99fc2cba183a854.jpg", @"http://upload-images.jianshu.io/upload_images/1896623-b99fc2cba183a854.jpg"]];
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

/*
    传值部分
 */
-(void) imageTapAction:(UITapGestureRecognizer *)tap
{
    NSMutableArray * photoViews = [NSMutableArray array];
    NSMutableArray * photoItems = [NSMutableArray array];
    NSMutableArray * photoPlaceItems = [NSMutableArray array];

    [self.objects enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TestTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        if (cell == nil) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.5, ScreenWidth * 0.5, 0, 0)];
            [photoViews addObject:image];
        }else{
            [photoViews addObject:cell.cellImageView];
        }
        [photoPlaceItems addObject:obj[0]];
        [photoItems addObject:obj[1]];
    }];
    CLPhotoBrowser *photo = [CLPhotoBrowser PhotoBrowser];
    photo.tapViewArr = photoViews;
    photo.indexPhoto = tap.view.tag;
    //占位图最好先设置
    photo.PhotoPlaceArr = photoPlaceItems;
    photo.PhotoArr = photoItems;
    [photo show];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [TestTableViewCell CL_cellWithNibTableView:tableView];
    
    NSArray * object = self.objects[indexPath.row];
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:object[0]]];
//    cell.cellImageView.image = [UIImage imageNamed:object[0]];
    cell.cellImageView.tag = indexPath.row + 1;
    cell.cellImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    [cell.cellImageView addGestureRecognizer:tap];
    
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
