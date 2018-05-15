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

@interface TodayViewController () <NCWidgetProviding>

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
    [WebViewConfigurator configWebView:self.webView];
}

@end
