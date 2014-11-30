//
//  AppDelegate.h
//  MarkdownKeybord-iOS
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^eventHandlerBlock)();

@interface MXToolbarButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title;

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent;

@end
