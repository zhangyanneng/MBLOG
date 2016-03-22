//
//  BlogCellModel.m
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "BlogCellModel.h"

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation BlogCellModel

//@synthesize content = _content;
//-(void)setContent:(NSString *)content{
//    _content = content;
//}


-(NSString*)content{
    
    CGFloat contentWith = [UIScreen mainScreen].bounds.size.width - 70;
    //内容
    CGRect textRect = [_content boundingRectWithSize:CGSizeMake(contentWith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:contentLabelFontSize ]} context:nil];
    if (textRect.size.height > maxContentLabelHeight) {
        _shouldShowMoreButton = YES;
    }else{
        _shouldShowMoreButton = NO;
    }
    return _content;
}

-(void)setIsOpening:(BOOL)isOpening{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    }else{
        _isOpening = isOpening;
    }
}

@end


@implementation BlogCellLikeItemsModel


@end

@implementation BlogCellCommentItemsModel


@end
