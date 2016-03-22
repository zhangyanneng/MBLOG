
//
//  PostBlogController.m
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "PostBlogController.h"
#import "MBProgressHUD+MJ.h"

@interface PostBlogController ()<UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textString;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;



- (IBAction)addImage:(id)sender;

- (IBAction)postBlogAction:(id)sender;

@end

@implementation PostBlogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 检测设备
//支持相机
-(BOOL) supportCamera{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//支持图库
-(BOOL) supportPhotoLibrary{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
//支持相册
-(BOOL) supportSavedPhotosAlbum{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}
#pragma  mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
     UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.imgView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}

- (IBAction)addImage:(id)sender {
    typeof(self) __weak weakSelf = self;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please choose image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    if([self supportCamera]){
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = NO;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:pickerController animated:YES completion:nil];
        }];
        [alert addAction:camera];
    }
    if([self supportPhotoLibrary]){
        UIAlertAction *library = [UIAlertAction actionWithTitle:@"PhotoLibrary" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = NO;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:pickerController animated:YES completion:nil];
        }];
        [alert addAction:library];
    }
    if ([self supportSavedPhotosAlbum]) {
        UIAlertAction *photosAlbum = [UIAlertAction actionWithTitle:@"PhotosAlbum" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = NO;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:pickerController animated:YES completion:nil];
        }];
        [alert addAction:photosAlbum];
    }
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)postBlogAction:(id)sender {
    [MBProgressHUD showMessage:@"sending..."];
     typeof(self) __weak weakSelf = self;
    //模拟2秒跳转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //移除遮盖
        [MBProgressHUD hideHUD];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        NSLog(@"send blog");
        
    });
    
   
}
#pragma mark textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
