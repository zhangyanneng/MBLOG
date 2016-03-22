//
//  BlogCellModel.h
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogCellLikeItemsModel, BlogCellCommentItemsModel;

@interface BlogCellModel : NSObject

@property (nonatomic, copy) NSString *iconImage;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *picutrePathArray;
@property (nonatomic,copy) NSString *time;

@property (nonatomic, strong) NSArray<BlogCellLikeItemsModel *> *likesItemsArray;
@property (nonatomic, strong) NSArray<BlogCellCommentItemsModel *> *commentItemsArray;



@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;


@end


@interface BlogCellLikeItemsModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end


@interface BlogCellCommentItemsModel : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *fromName;
@property (nonatomic, copy) NSString *fromId;

@property (nonatomic, copy) NSString *replyName;
@property (nonatomic, copy) NSString *replyId;

@end
