//
//  MessageCell.m
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastContent;
@property (weak, nonatomic) IBOutlet UILabel *newsCount;


@end

@implementation MessageCell


- (void)awakeFromNib {
    // Initialization code
    self.newsCount.layer.cornerRadius = 10.0f;
    self.newsCount.layer.masksToBounds = YES;
    self.newsCount.textColor = [UIColor whiteColor];
    self.newsCount.backgroundColor = [UIColor colorWithRed:233/255.0f green:10/255.0f blue:1/255.0f alpha:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
