//
//  AppDelegate.h
//  MarkdownKeybord-iOS
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MXToolbarButton.h"

@interface MXToolbarButton ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) eventHandlerBlock buttonPressBlock;

@end

@implementation MXToolbarButton

+ (instancetype)buttonWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title {
    _title = title;
    return [self init];
}

- (id)init
{
    CGSize sizeOfText = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25.f]}];
    
    self = [super initWithFrame:CGRectMake(0, 0, sizeOfText.width + 18.104, sizeOfText.height + 10.298)];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.0];
        
        self.layer.cornerRadius = 3.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        
        [self setTitle:self.title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithWhite:0.500 alpha:1.0] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:25.f];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.500 alpha:1.0];
    }
    return self;
}

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
    self.buttonPressBlock = eventHandler;
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}

- (void)buttonPressed {
    self.buttonPressBlock();
}

@end
