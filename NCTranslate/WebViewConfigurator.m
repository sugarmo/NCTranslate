//
//  WebViewConfigurator.m
//  NCTranslate
//
//  Created by Steven Mok on 2018/5/14.
//  Copyright © 2018年 SUGARMO. All rights reserved.
//

#import "WebViewConfigurator.h"

@implementation WebViewConfigurator

+ (void)configWebView:(WKWebView *)webView
{
    [webView.configuration.userContentController addUserScript:[self injectScript]];

    NSURL *url = [NSURL URLWithString:@"https://translate.google.cn/m/translate#en/zh-CN/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
}

+ (WKUserScript *)injectScript
{
    WKUserScript *s = [[WKUserScript alloc] initWithSource:[self injectJS] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    return s;
}

+ (NSString *)injectJS
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"inject" ofType:@"js"];
    if (path) {
        return [NSString stringWithContentsOfFile:path usedEncoding:NULL error:NULL];
    }
    return nil;
}

@end
