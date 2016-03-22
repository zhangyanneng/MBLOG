//
//  PhotoContainerView.m
//  MBlog
//
//  Created by zyn on 16/3/10.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "PhotoContainerView.h"
#import "SDPhotoBrowser.h"
#import "UIView+SDAutoLayout.h"

@interface PhotoContainerView()<SDPhotoBrowserDelegate>

@property(nonatomic,strong) NSArray *imageViewArray;
@end
@implementation PhotoContainerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    //设置9宫格图片
    for (int i=0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        //是否用户触发的事件被该视图对象忽略和把该视图对象从事件响应队列中移除
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewArray = [temp copy];
}

-(void)setPicturePathArray:(NSArray *)picturePathArray{
    _picturePathArray = picturePathArray;
    //隐藏多余的imageView
    for (long i = _picturePathArray.count; i<self.imageViewArray.count; i++) {
        UIImageView *view = [self.imageViewArray objectAtIndex:i];
        view.hidden = YES;
    }
    //
    if (_picturePathArray.count == 0) {
        self.height = 0;
        self.fixedHeight = 0;
        return;
    }
    CGFloat itemW = [self itemWithForPicPathArray:_picturePathArray];
    CGFloat itemH = 0;
    
    if (_picturePathArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picturePathArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    }else{
        itemH = itemW;
    }
    //
    long perRowItemCount = [self perRowItemCountForPicturePathArray:_picturePathArray];
    CGFloat margin = 5;
    [_picturePathArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [self.imageViewArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columnIndex *(itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    CGFloat w = perRowItemCount * itemW + (perRowItemCount -1)*margin;
    int columnCount = ceilf(_picturePathArray.count *1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1)*margin;
    
    self.height = h;
    self.width = w;
    
    self.fixedHeight = @(h);
    self.fixedWith = @(w);
}

#pragma mark private action
- (void)tapImageView:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc]init];
    browser.currentImageIndex = view.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = _picturePathArray.count;
    browser.delegate = self;
    [browser show];
}

-(CGFloat)itemWithForPicPathArray:(NSArray*)picturePathArray{
    if (picturePathArray.count == 1) {
        return 120;
    }else{
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}
-(NSInteger)perRowItemCountForPicturePathArray:(NSArray *)array{
    if (array.count <3) {
        return array.count;
    }else if(array.count <= 4){
        return 2;
    }else{
        return 3;
    }
}

#pragma mark SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picturePathArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
