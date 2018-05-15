//
//  ViewController.m
//  NCTranslate
//
//  Created by Steven Mok on 2018/5/14.
//  Copyright © 2018年 SUGARMO. All rights reserved.
//

#import "ViewController.h"
#import "WebViewConfigurator.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [WebViewConfigurator configWebView:self.webView];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
