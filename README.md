# CLPhotoBrower

#图片浏览器
## 本库依赖于SDWebImage
## 使用方法
```
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
```
