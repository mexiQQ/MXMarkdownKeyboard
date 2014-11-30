//
//  ViewController.m
//  MXMarkdownKeyboardDemo
//
//  Created by MexiQQ on 14/11/30.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.font = [UIFont fontWithName:@"Arial" size:20];
    [self.view addSubview:_textView];
    
    //just a line
    _textView.inputAccessoryView = [MXKeyboardToolbar toolbarViewWithTextView:_textView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
