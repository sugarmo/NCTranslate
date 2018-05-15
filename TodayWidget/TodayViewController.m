//
//  TodayViewController.m
//  TodayWidget
//
//  Created by Steven Mok on 2018/5/14.
//  Copyright © 2018年 SUGARMO. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WebViewConfigurator.h"
#import "PRCColor.h"

#define DEFAULT_HEIGHT 380

@interface TodayViewController () <NCWidgetProviding>

@property (assign) CGFloat currentHeight;

@end

@implementation TodayViewController

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler
{
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    completionHandler(NCUpdateResultNoData);
}

- (NSEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(NSEdgeInsets)defaultMarginInset
{
    return NSEdgeInsetsZero;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.currentHeight = DEFAULT_HEIGHT;

    self.expandButton.title = @"Expand";
    self.expandButton.wantsLayer = YES;
    self.expandButton.layer.backgroundColor = [self buttonBackgroundColor].CGColor;

    [WebViewConfigurator configWebView:self.webView];
}

- (NSColor *)buttonBackgroundColor
{
    return [NSColor prc_colorWithRGBString:@"#FFFFFF"];
}

//- (NSColor *)buttonTitleColor
//{
//    return [NSColor whiteColor];
//}

//- (NSAttributedString *)titleWithText:(NSString *)text
//{
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
//    NSRange range = NSMakeRange(0, text.length);
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[self buttonTitleColor] range:range];
//    return attributedString;
//}

- (void)getWebViewHeight:(void (^)(CGFloat height))block
{
    if (block) {
        [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError *_Nullable error) {
            if (error == nil) {
                CGFloat height = [result doubleValue];
                block(height);
            } else {
                block(-1);
            }
        }];
    }
}

- (IBAction)showAllContent:(id)sender
{
    if (self.currentHeight > DEFAULT_HEIGHT) {
        self.currentHeight = DEFAULT_HEIGHT;
        self.preferredContentSize = CGSizeMake(0, DEFAULT_HEIGHT);
        self.expandButton.title = @"Expand";
    } else {
        [self getWebViewHeight:^(CGFloat height) {
            if (height > DEFAULT_HEIGHT) {
                CGSize size = self.preferredContentSize;
                size.height = height;
                self.preferredContentSize = size;

                self.currentHeight = height;
                self.expandButton.title = @"Collapse";
            }
        }];
    }
}

@end
