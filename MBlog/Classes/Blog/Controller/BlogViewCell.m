//
//  BlogViewCell.m
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "BlogViewCell.h"
#import "PhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "BlogCommentView.h"
#import "BlogCellModel.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface BlogViewCell()
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UILabel *_contontLabel;
    PhotoContainerView *_picContentView;
    UIButton *_moreButton;
    UIButton *_operationButton;
    UIButton *_likeButton;
    UILabel *_timeLabel;
    BlogCommentView *_commentView;
    BOOL _shouldOpenContentLabel;
}
@end

@implementation BlogViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUpView{
    _shouldOpenContentLabel = NO;
    _iconImageView = [UIImageView new];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:71/255.0 blue:121.0/255.0 alpha:1.0];
    
    _contontLabel = [UILabel new];
    _contontLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contontLabel.font.lineHeight * 3;
    }
    _picContentView = [[PhotoContainerView alloc]init];
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"All" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _likeButton = [UIButton new];
    [_likeButton setImage:[UIImage imageNamed:@"likes"] forState:UIControlStateNormal];
    [_likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    _commentView = [[BlogCommentView alloc]init];
    
    NSArray *views = @[_iconImageView,_nameLabel,_contontLabel,_picContentView,_moreButton,_likeButton,_operationButton,_timeLabel,_commentView];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconImageView.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .heightIs(40).widthIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImageView,margin)
    .topEqualToView(_iconImageView)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contontLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,margin)
    .rightSpaceToView(contentView,margin)
    .autoHeightRatio(0);
    
    _moreButton.sd_layout
    .leftEqualToView(_contontLabel)
    .topSpaceToView(_contontLabel,0)
    .widthIs(50);
    
    _picContentView.sd_layout.
    leftEqualToView(_contontLabel);
    
    _timeLabel.sd_layout
    .leftEqualToView(_contontLabel)
    .topSpaceToView(_picContentView,margin)
    .heightIs(15)
    .autoHeightRatio(0);
    
    _operationButton.sd_layout
    .rightSpaceToView(contentView,margin)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    _likeButton.sd_layout
    .rightSpaceToView(_operationButton,5)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    _commentView.sd_layout
    .leftEqualToView(_contontLabel)
    .topSpaceToView(_timeLabel,margin)
    .rightSpaceToView(self.contentView,margin);
    
}

-(void)setModel:(BlogCellModel *)model{
    _model = model;
    
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likesItemsArray commentItemsArray:model.commentItemsArray];
    
    _shouldOpenContentLabel = NO;
    _iconImageView.image = [UIImage imageNamed:model.iconImage];
    _nameLabel.text = model.name;
    [_nameLabel sizeToFit]; // 防止单行文本label在重用时宽度计算不准的问题
    
    _contontLabel.text = model.content;
    _picContentView.picturePathArray = model.picutrePathArray;
    
    if (model.shouldShowMoreButton) {
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) {
            _contontLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"Close" forState:UIControlStateNormal];
        }else{
            _contontLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"Open" forState:UIControlStateNormal];
        }
    }else{
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    CGFloat picContainerTopMargin = 0;
    
    if (model.picutrePathArray.count) {
        picContainerTopMargin = 10;
    }
    _picContentView.sd_layout.topSpaceToView(_moreButton,picContainerTopMargin);
    
    _timeLabel.text = model.time;
    
    UIView *bottomView;
    
    if (!model.commentItemsArray && !model.likesItemsArray) {
        //没有评论和点赞
        _commentView.fixedHeight = @0;
        _commentView.fixedWith = @0;
        _commentView.sd_layout.topSpaceToView(_timeLabel,0);
        bottomView = _timeLabel;
    }else{
        _commentView.fixedWith = nil;
        _commentView.fixedHeight = nil;
        _commentView.sd_layout.topSpaceToView(_timeLabel,10);
        bottomView  = _commentView;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
}

#pragma mark private method
-(void)moreButtonClicked{
    if(self.moreButtonClickBlock){
        self.moreButtonClickBlock(self.indexPath);
    }
}

-(void)operationButtonClick{
    [self.delegate clickedCommentButton];
    
}
-(void)likeButtonClick{
    [self.delegate clickedLikeButton];
}
@end
