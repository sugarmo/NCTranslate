//
//  TodayViewController.h
//  TodayWidget
//
//  Created by Steven Mok on 2018/5/14.
//  Copyright © 2018年 SUGARMO. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface TodayViewController : NSViewController

@property (weak) IBOutlet WKWebView *webView;

@property (weak) IBOutlet NSButton *expandButton;

@end
