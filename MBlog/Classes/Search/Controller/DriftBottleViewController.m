//
//  DriftBottleViewController.m
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "DriftBottleViewController.h"
#import "MakeComment.h"

#define kMaxHeight 60.0f
#define kMinHeight 45.0f

@interface DriftBottleViewController ()

@property(nonatomic,strong) MakeComment *makeCommentBar;

@end

@implementation DriftBottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _makeCommentBar = [[MakeComment alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kMinHeight, self.view.frame.size.width, kMinHeight)];
    [self.view addSubview:_makeCommentBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
