//
//  MakeComment.h
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputComentDelegate <NSObject>

@optional
-(void)createComment:(NSString*)commentId text:String;

@end


@interface MakeComment : UIView

@property(nonatomic,assign) id<InputComentDelegate> delegate;

-(void)addKeybordNotify;
-(void)removeKeybordNotify;

-(void)addViewObserver;
-(void)removeViewObserver;

-(void)showInputView;

-(void) setPlaceHolder:(NSString *) text;

@end
