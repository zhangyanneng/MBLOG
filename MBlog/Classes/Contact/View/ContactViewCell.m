//
//  ContactViewCell.m
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "ContactViewCell.h"

@implementation ContactViewCell

+(instancetype)ContactCellWithTableView:(UITableView*)tableView{
    static NSString *identifier = @"ContactCell";
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ContactViewCell" owner:nil options:nil].firstObject;
    }
    return cell;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
