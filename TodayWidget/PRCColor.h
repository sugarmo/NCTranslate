//
//  ZNSColor.h
//  PRCKit
//
//  Created by Steven Mok on 13-10-11.
//  Copyright (c) 2013年 ZAKER. All rights reserved.
//

#import <AppKit/AppKit.h>

extern const CGFloat PRCPerceivedBrightnessInvalid;


@interface NSColor (PRCAdditions)

+ (NSColor *)prc_colorWithRGBHex:(NSUInteger)hex;
+ (NSColor *)prc_colorWithRGBHex:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (NSColor *)prc_colorWithRGBString:(NSString *)string alpha:(CGFloat)alpha;
+ (NSColor *)prc_colorWithRGBString:(NSString *)string;

- (NSString *)prc_RGBStringRepresentation;

- (NSString *)prc_RGBStringRepresentationWitAlpha:(BOOL)alphaFlag;

+ (NSColor *)prc_focusOrange;

+ (NSColor *)prc_lighterSeparatorGray;

+ (NSColor *)prc_separatorGray;

+ (NSColor *)prc_subtitleGray;

+ (NSColor *)prc_titleBlack;

- (NSColor *)prc_colorWithAlpha:(CGFloat)alpha;

- (NSColor *)prc_colorByInterpolatingWith:(NSColor *)color factor:(CGFloat)factor;

- (CGFloat)prc_perceivedBrightness;

- (BOOL)prc_prefersLightContent;

@end

@interface NSColor (PRCStyleColor)

+ (NSColor *)prc_noticeColor;

@end

