//
//  MakeComment.m
//  MBlog
//
//  Created by zyn on 16/3/13.
//  Copyright © 2016年 zyn. All rights reserved.
//

#import "MakeComment.h"
#import "UIView+SDAutoLayout.h"

#define MaxHeight 60.0f
#define MinHeight 45.0f
#define InputViewHeight  45
#define InputViewObserveKeyPath @"inputViewOffsetY"

@interface MakeComment()<UITextFieldDelegate>

@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UIView *inputView;

@property(nonatomic,strong) UIButton *faceButton;
@property(nonatomic,strong) UIButton *moreButton;
@property (strong,nonatomic) UITextField *inputTextView;

@property (assign, nonatomic) NSTimeInterval keyboardAnimationDuration;
@property (assign, nonatomic) NSUInteger keyboardAnimationCurve;
@property (assign, nonatomic) CGFloat inputViewOffsetY;

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation MakeComment

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _keyboardAnimationDuration = 0.25;
        _keyboardAnimationCurve = 7;
        [self setup];
    }
    return self;
}
-(void)dealloc{
    [_maskView removeGestureRecognizer:_panGestureRecognizer];
    [_maskView removeGestureRecognizer:_tapGestureRecognizer];

}

-(void)setup{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:_maskView];
        _maskView.backgroundColor = [UIColor darkGrayColor];
        _maskView.alpha = 0.4;
        _maskView.hidden = YES;
    }
    if (!_inputView) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - InputViewHeight,self.frame.size.width ,InputViewHeight)];
        _inputView.backgroundColor = [UIColor colorWithWhite:250/255.0 alpha:1.0];
        _inputView.hidden = YES;
        
        [self addSubview:_inputView];
    }
    
    _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _faceButton.tag = 1;
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"chat_bar_face_normal"] forState:UIControlStateNormal];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"chat_bar_face_highlight"] forState:UIControlStateSelected];
    [_faceButton addTarget:self action:@selector(faceButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_faceButton sizeToFit];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _moreButton.tag = 2;
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"chat_bar_more_normal"] forState:UIControlStateNormal];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"chat_bar_input_normal"] forState:UIControlStateSelected];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton sizeToFit];
    
    
    _inputTextView = [[UITextField alloc] init];
    
    _inputTextView.keyboardType = UIKeyboardTypeDefault;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.layer.borderWidth = 0.5;
    _inputTextView.layer.cornerRadius = 15;
    _inputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _inputTextView.font = [UIFont systemFontOfSize:15];
    _inputTextView.delegate = self;
    
    [_inputView addSubview:_faceButton];
    [_inputView addSubview:_moreButton];
//    [_inputView addSubview:_textView];
    [_inputView addSubview:_inputTextView];
    
    UIImageView *topLine = [[UIImageView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:184/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f];
    [_inputView addSubview:topLine];
    
    //布局
    topLine.sd_layout
    .leftEqualToView(_inputView)
    .rightEqualToView(_inputView)
    .topEqualToView(_inputView)
    .heightIs(.5);
    
    _moreButton.sd_layout
    .topSpaceToView(_inputView,8)
    .rightSpaceToView(_inputView,10)
    .heightIs(30)
    .widthEqualToHeight();
    
    _faceButton.sd_layout
    .topSpaceToView(_inputView,8)
    .rightSpaceToView(_moreButton,10)
    .heightIs(30)
    .widthEqualToHeight();
    
    _inputTextView.sd_layout
    .leftSpaceToView(_inputView,10)
    .topSpaceToView(_inputView,4)
    .rightSpaceToView(_faceButton,10)
    .bottomSpaceToView(_inputView,4);
    
    
    if (_panGestureRecognizer == nil) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewPanAndTap:)];
        [_maskView addGestureRecognizer:_panGestureRecognizer];
        _panGestureRecognizer.maximumNumberOfTouches = 1;
        
    }
    
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewPanAndTap:)];
        [_maskView addGestureRecognizer:_tapGestureRecognizer];
    }
}
-(void) onTableViewPanAndTap:(UIGestureRecognizer *) gesture
{
    [self hideInputView];
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideInputView];
    return YES;
}

#pragma mark private

-(void)faceButtonClicked{
    NSLog(@"clicked facebutton");
}
-(void)moreButtonClicked{
     NSLog(@"clicked moreButton");
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:.3 animations:^{
            [_inputView setFrame:frame];
        }];
    }else{
        [_inputView setFrame:frame];
    }
}

-(void)addKeybordNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)removeKeybordNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark keyboard private

-(void)onKeyboardShow:(NSNotification *) notify{
    NSDictionary *info = notify.userInfo;
    CGRect frame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    _keyboardAnimationCurve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [self changeInputViewPosition:(frame.origin.y - InputViewHeight)];
    
}

#pragma mark Observer

-(void)addViewObserver{
    [self addObserver:self forKeyPath:InputViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeViewObserver{
    [self removeObserver:self forKeyPath:InputViewObserveKeyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:InputViewObserveKeyPath]) {
        CGFloat newOffSetY = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
        [self changeInputViewPosition:newOffSetY];
    }
}

-(void)hideInputView{
    self.hidden = YES;
    _inputView.hidden = YES;
    [self.inputTextView resignFirstResponder];
    self.inputTextView.text = @"";
    CGFloat offsetY = CGRectGetHeight(self.frame) - InputViewHeight ;
    [self changeInputViewPosition:offsetY];
}

-(void)showInputView{
    self.hidden = NO;
    self.inputView.hidden = NO;
    [self.inputTextView becomeFirstResponder];
}

-(void)setPlaceHolder:(NSString *) text{
    
}

-(void)changeInputViewPosition:(CGFloat)newOffSetY{
    
    _maskView.hidden = !(newOffSetY < (self.frame.size.height - InputViewHeight));
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_keyboardAnimationDuration];
    [UIView setAnimationCurve:_keyboardAnimationCurve];
    
    _inputView.frame = CGRectMake(_inputView.frame.origin.x, newOffSetY, _inputView.frame.size.width, _inputView.frame.size.height);
    
    [UIView commitAnimations];
}

-(void) changeInputViewOffsetY:(CGFloat) offsetY
{
    [self setValue: [NSNumber numberWithDouble:offsetY] forKey:InputViewObserveKeyPath];
    
}

@end
