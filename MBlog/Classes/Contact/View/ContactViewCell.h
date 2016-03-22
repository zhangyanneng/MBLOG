//
//  ContactViewCell.h
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *signature;

+(instancetype)ContactCellWithTableView:(UITableView*)tableView;
@end
