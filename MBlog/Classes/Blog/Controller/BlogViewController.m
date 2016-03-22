//
//  BlogViewController.m
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "BlogViewController.h"
#import "BlogViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "SDRefresh.h"
#import "PostBlogController.h"
#import "UIView+SDAutoLayout.h"
#import "BlogCellModel.h"

#import "MakeComment.h"

#define kMaxHeight 60.0f
#define kMinHeight 45.0f

static NSString *cellIdentifier =@"BlogCellIdentifier";

@interface BlogViewController ()<InputComentDelegate,CommentCellDelegate>
{
    SDRefreshHeaderView *refreshHeader;
    SDRefreshFooterView *refreshFooter;
    
}

@property(nonatomic,strong) MakeComment *makeCommentBar;


@end

@implementation BlogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.dataArray) {
        _dataArray = [NSMutableArray new];
    }
    [self loadData];
    __weak typeof(self) weakSelf = self;
    
    [self.tableView registerClass:[BlogViewCell class] forCellReuseIdentifier:cellIdentifier];
    if (!_makeCommentBar) {
        _makeCommentBar = [[MakeComment alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _makeCommentBar.hidden = YES;
        _makeCommentBar.delegate = self;
        [self.tabBarController.view addSubview:_makeCommentBar];
    }
}

-(void)loadData{
    
    BlogCellModel *model = [[BlogCellModel alloc]init];
    
    model.iconImage = @"0.jpg";
    model.name = @"Matt";
    model.picutrePathArray = @[@"pic0.jpg",@"pic1.jpg"];
    model.content = @"Hello World";
    //    model.time = @"1 minues";
    BlogCellCommentItemsModel *m = [BlogCellCommentItemsModel new];
    m.fromName = @"Jack";
    m.fromId = @"111" ;
    m.content = @"this is a joke!";
    
    BlogCellCommentItemsModel *m1 = [BlogCellCommentItemsModel new];
    m1.fromName = @"Matt";
    m1.fromId = @"112" ;
    m1.replyName = @"Jack";
    m1.replyId = @"111";
    m1.content = @"No,you arg dog.";
    
    model.commentItemsArray = @[m,m1];
    
    BlogCellModel *model1 = [[BlogCellModel alloc]init];
    
    model1.iconImage = @"1.jpg";
    model1.name = @"Kate";
    model1.picutrePathArray = @[@"pic2.jpg"];
    model1.content = @"HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld ";
    model1.time = @"1 minues";
    
    
    BlogCellLikeItemsModel *like = [BlogCellLikeItemsModel new];
    like.userName = @"Jack";
    like.userId = @"100";
    BlogCellLikeItemsModel *like1 = [BlogCellLikeItemsModel new];
    like1.userName = @"Tom";
    like1.userId = @"101";
    
    model.likesItemsArray = @[like,like1];
    
    BlogCellModel *model2 = [[BlogCellModel alloc]init];
    
    model2.iconImage = @"1.jpg";
    model2.name = @"Kate";
    model2.picutrePathArray = @[@"pic2.jpg"];
    model2.content = @"numberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)section";
    model2.time = @"1 minues";
    
    BlogCellModel *model3 = [[BlogCellModel alloc]init];
    
    model3.iconImage = @"1.jpg";
    model3.name = @"Kate";
    model3.picutrePathArray = @[@"pic2.jpg"];
    model3.content = @"numberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)sectionnumberOfRowsInSection:(NSInteger)section";
    //    model3.time = @"1 minues";
    
    [self.dataArray addObjectsFromArray: @[model,model3,model2,model1]];
}
-(void)viewWillAppear:(BOOL)animated{
    [_makeCommentBar addViewObserver];
    [_makeCommentBar addKeybordNotify];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_makeCommentBar removeViewObserver];
    [_makeCommentBar removeKeybordNotify];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickBlock) {
        [cell setMoreButtonClickBlock:^(NSIndexPath *indexPath) {
            BlogCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[BlogViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

//-(MakeComment*)makeCommentBar{
//   
//
//    return _makeCommentBar;
//}
#pragma mark
-(void)clickedCommentButton{
    _makeCommentBar.hidden = NO;
    [_makeCommentBar showInputView];
}
-(void)clickedLikeButton{
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PostBlogController *viewContriller = segue.destinationViewController;
    viewContriller.hidesBottomBarWhenPushed = YES;
}

@end
