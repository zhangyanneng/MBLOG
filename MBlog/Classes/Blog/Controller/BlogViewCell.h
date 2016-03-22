//
//  BlogViewCell.h
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogCellModel;

@protocol CommentCellDelegate <NSObject>

@required
-(void)clickedCommentButton;
-(void)clickedLikeButton;

@end

@interface BlogViewCell : UITableViewCell

@property (nonatomic,assign) id<CommentCellDelegate> delegate;

@property (nonatomic,strong) BlogCellModel *model;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) void (^moreButtonClickBlock)(NSIndexPath *indexPath);

@end
