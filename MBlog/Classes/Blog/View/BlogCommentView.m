//
//  BlogCommentView.m
//  MBlog
//
//  Created by zyn on 16/3/11.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "BlogCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "MLLinkLabel.h"
#import "BlogCellModel.h"


@interface BlogCommentView()<MLLinkLabelDelegate>


@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;


@end

@implementation BlogCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _bgImageView = [UIImageView new];
    UIImage *bgImage = [[UIImage imageNamed:@"CommentBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    _bgImageView.image = bgImage;
    [self addSubview:_bgImageView];
    
    _likeLabel = [UILabel new];
    [self addSubview:_likeLabel];
    
    _likeLableBottomLine = [UIView new];
    _likeLableBottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_likeLableBottomLine];
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    
    long originalLabelsCount = self.commentLabelsArray.count;
    long needsToAddCount = commentItemsArray.count > originalLabelsCount ? (commentItemsArray.count - originalLabelsCount) : 0;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        UIColor *highLightColor = [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0];
        label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
    }
    
    for (int i = 0; i < commentItemsArray.count; i++) {
        BlogCellCommentItemsModel *model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
    }
}

- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    [_likeLabel sd_clearAutoLayoutSettings];
    _likeLabel.frame = CGRectZero;
    
    
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            [label sd_clearAutoLayoutSettings];
            label.frame = CGRectZero;
        }];
    }
    
    CGFloat margin = 5;
    
    if (likeItemsArray.count) {
        _likeLabel.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, margin)
        .autoHeightRatio(0);
        
        _likeLabel.isAttributedContent = YES;
    }
    
    UIView *lastTopView = _likeLabel;
    
    for (int i = 0; i < self.commentItemsArray.count; i++) {
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        CGFloat topMargin = i == 0 ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(lastTopView, topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        lastTopView = label;
    }
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
    
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BlogCellCommentItemsModel *)model
{
    NSString *text = model.fromName;
    if (model.replyName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@" reply %@", model.replyName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@":%@", model.content]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.fromId} range:[text rangeOfString:model.fromName]];
    if (model.replyName) {
        [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.replyId} range:[text rangeOfString:model.replyName]];
    }
    return attString;
}


#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
}

@end
