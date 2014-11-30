//
//  AppDelegate.h
//  MarkdownKeybord-iOS
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MXKeyboardToolbar.h"
#import "MXToolbarButton.h"

@interface MXKeyboardToolbar ()

@property (nonatomic,strong) UIView *toolbarView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) CALayer *topBorder;
@property (nonatomic,strong) NSArray *buttonsToAdd;

@end

@implementation MXKeyboardToolbar

+ (instancetype)toolbarViewWithTextView: (UITextView *)textView{
    return [[MXKeyboardToolbar alloc] initWithTextView:textView];
}

- (id)initWithTextView: (UITextView *)textView {
    self = [super initWithFrame:CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 53)];
    self.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.0];
    if (self) {
        _buttonsToAdd = [self buttonsForTextView:textView];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:[self inputAccessoryView]];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = _toolbarView.bounds;
    frame.size.height = 0.5f;
    _topBorder.frame = frame;
}

- (UIView*)inputAccessoryView {
    _toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    _toolbarView.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.0];
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    _topBorder = [CALayer layer];
    _topBorder.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.5f);
    _topBorder.backgroundColor = [UIColor colorWithWhite:0.678 alpha:1.0].CGColor;
    
    [_toolbarView.layer addSublayer:_topBorder];
    [_toolbarView addSubview:[self fakeToolbar]];

    return _toolbarView;
}

- (UIScrollView*)fakeToolbar {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 53)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(6.0f, 0.0f, 6.0f, 6.0f);
    
    NSUInteger index = 0;
    NSUInteger originX = 8;
    
    CGRect originFrame;
    
    for (MXToolbarButton *eachButton in _buttonsToAdd) {
        originFrame = CGRectMake(originX, 0, eachButton.frame.size.width, eachButton.frame.size.height);
        eachButton.frame = originFrame;
        
        [_scrollView addSubview:eachButton];
        
        originX = originX + eachButton.bounds.size.width + 8;
        index++;
    }
    
    CGSize contentSize = _scrollView.contentSize;
    contentSize.width = originX - 8;
    _scrollView.contentSize = contentSize;
    
    return _scrollView;
}

- (NSArray*)buttonsForTextView:(UITextView *)textView {
    return @[
             [self createButtonWithTitle:@"H" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 3;
                 selectionRange.length = 4;
                 [textView insertText:@"## head"];
                 textView.selectedRange = selectionRange;

             }],
             
             [self createButtonWithTitle:@"B" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 2;
                 selectionRange.length = 6;
                 [textView insertText:@"**Strong**"];
                 textView.selectedRange = selectionRange;
             }],
             
             [self createButtonWithTitle:@"/" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 1;
                 selectionRange.length = 11;
                 [textView insertText:@"*Italic text*"];
                 textView.selectedRange = selectionRange;

             }],
             
             [self createButtonWithTitle:@"---" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 if (textView.text.length == 0) {
                     selectionRange.location += 4;
                     [textView insertText:@"---\n"];
                 }
                 else {
                     selectionRange.location += 5;
                     [textView insertText:@"\n---\n"];
                 }
                 textView.selectedRange = selectionRange;

             }],
             
             [self createButtonWithTitle:@">" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 3;
                 if (textView.text.length == 0) {
                     [textView insertText:@"> "];
                 }
                 else {
                     [textView insertText:@"\n> "];
                 }
                 textView.selectedRange = selectionRange;
             }],
             
             [self createButtonWithTitle:@"Image" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 16;
                 selectionRange.length = 8;
                 [textView insertText:@"![Image](http://resource)"];
                 textView.selectedRange = selectionRange;
             }],
             
             [self createButtonWithTitle:@"Link" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 selectionRange.location += 12;
                 selectionRange.length = 7;
                 [textView insertText:@"[链接](http://example)"];
                 textView.selectedRange = selectionRange;

             }],
             
             [self createButtonWithTitle:@"Code" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 if (textView.text.length == 0) {
                     selectionRange.location += 4;
                     [textView insertText:@"```\n\n```"];
                 }
                 else {
                     selectionRange.location += 5;
                     [textView insertText:@"\n```\n\n```"];
                 }
                 textView.selectedRange = selectionRange;
             }],
             
             [self createButtonWithTitle:@"List" andEventHandler:^{
                 NSRange selectionRange = textView.selectedRange;
                 if (textView.text.length == 0) {
                     selectionRange.location += 2;
                     selectionRange.length = 9;
                     [textView insertText:@"- List Item"];
                 }
                 else {
                     selectionRange.location += 3;
                     selectionRange.length = 9;
                     [textView insertText:@"\n- List Item"];
                 }
                 textView.selectedRange = selectionRange;
             }]];
}

- (MXToolbarButton*)createButtonWithTitle:(NSString*)title andEventHandler:(void(^)())handler {
    MXToolbarButton *button = [MXToolbarButton buttonWithTitle:title];
    [button addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
