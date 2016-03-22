//
//  SearchViewController.m
//  MBlog
//
//  Created by zyn on 16/3/9.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "SearchViewController.h"
#import "ShakeViewController.h"
#import "PeopleNearbyViewController.h"
#import "DriftBottleViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShakeIdentifier"]) {
        ShakeViewController *shake = segue.destinationViewController;
        shake.hidesBottomBarWhenPushed = YES;
        shake.title = @"Shake";
        
    }else if ([segue.identifier isEqualToString:@"PeopleNearbyIdentifier"]){
        PeopleNearbyViewController *peopleNearby = segue.destinationViewController;
        peopleNearby.hidesBottomBarWhenPushed = YES;
        peopleNearby.title = @"People Nearby";
    }else if ([segue.identifier isEqualToString:@"DriftBottleIdentifier"]){
        DriftBottleViewController *driftBottle = segue.destinationViewController;
        driftBottle.hidesBottomBarWhenPushed = YES;
        driftBottle.title = @"Drift Bottle";
    }
    
    
    
    
    
}

@end
