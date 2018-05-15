//
//  ZNSColor.m
//  PRCKit
//
//  Created by Steven Mok on 13-10-11.
//  Copyright (c) 2013年 ZAKER. All rights reserved.
//

#import "PRCColor.h"

const CGFloat PRCPerceivedBrightnessInvalid = -1.f;

@implementation NSColor (PRCAdditions)

+ (NSColor *)prc_colorWithRGBString:(NSString *)string
{
    return [[self class] prc_colorWithRGBString:string alpha:1.0f];
}

+ (NSColor *)prc_colorWithRGBString:(NSString *)string alpha:(CGFloat)alpha
{
    if (!string || [string length] < 6) {
        return nil;
    }

    const char *cStr = [string cStringUsingEncoding:NSASCIIStringEncoding];
    long hex;
    if ([string length] <= 6) {
        hex = strtol(cStr, NULL, 16);
    } else {
        hex = strtol(cStr + 1, NULL, 16);
    }
    return [self prc_colorWithRGBHex:(NSUInteger)hex alpha:alpha];
}

+ (NSColor *)prc_colorWithRGBHex:(NSUInteger)hex
{
    return [self prc_colorWithRGBHex:hex alpha:1.0f];
}

+ (NSColor *)prc_colorWithRGBHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    unsigned char red = (hex >> 16) & 0xFF;
    unsigned char green = (hex >> 8) & 0xFF;
    unsigned char blue = hex & 0xFF;

    return [NSColor colorWithRed:(CGFloat)red / 255.0f
                           green:(CGFloat)green / 255.0f
                            blue:(CGFloat)blue / 255.0f
                           alpha:alpha];
}

- (NSString *)prc_RGBStringRepresentation
{
    return [self prc_RGBStringRepresentationWitAlpha:NO];
}

- (NSString *)prc_RGBStringRepresentationWitAlpha:(BOOL)alphaFlag
{
    size_t componentCount = CGColorGetNumberOfComponents(self.CGColor);

    if (componentCount != 4) {
        return @"#000000"; // return black color if color is not in RGB color space
    }

    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = components[3];

    NSString *colorString;

    if (alphaFlag) {
        colorString = [NSString stringWithFormat:@"#%.2X%.2X%.2X %.2f", (unsigned int)(red * 255.f), (unsigned int)(green * 255.f), (unsigned int)(blue * 255.f), alpha];
    } else {
        colorString = [NSString stringWithFormat:@"#%.2X%.2X%.2X", (unsigned int)(red * 255.f), (unsigned int)(green * 255.f), (unsigned int)(blue * 255.f)];
    }

    return colorString;
}

+ (NSColor *)prc_focusOrange
{
    return [NSColor prc_colorWithRGBString:@"#fb4747"];
}

+ (NSColor *)prc_lighterSeparatorGray
{
    return [self prc_colorWithRGBString:@"#f8f8f8"];
}

+ (NSColor *)prc_separatorGray
{
    return [self prc_colorWithRGBString:@"#e0e0e0"];
}

+ (NSColor *)prc_subtitleGray
{
    return [self prc_colorWithRGBString:@"#ababab"];
}

+ (NSColor *)prc_titleBlack
{
    return [self prc_colorWithRGBString:@"#262626"];
}

- (NSColor *)prc_colorByInterpolatingWith:(NSColor *)color factor:(CGFloat)factor
{
    factor = MIN(MAX(factor, 0.0), 1.0);

    const CGFloat *startComponent = CGColorGetComponents(self.CGColor);
    const CGFloat *endComponent = CGColorGetComponents(color.CGColor);

    float startAlpha = CGColorGetAlpha(self.CGColor);
    float endAlpha = CGColorGetAlpha(color.CGColor);

    float r = startComponent[0] + (endComponent[0] - startComponent[0]) * factor;
    float g = startComponent[1] + (endComponent[1] - startComponent[1]) * factor;
    float b = startComponent[2] + (endComponent[2] - startComponent[2]) * factor;
    float a = startAlpha + (endAlpha - startAlpha) * factor;

    return [NSColor colorWithRed:r green:g blue:b alpha:a];
}

- (NSColor *)prc_colorWithAlpha:(CGFloat)alpha
{
    CGColorRef cgcolor = CGColorCreateCopyWithAlpha(self.CGColor, alpha);
    NSColor *result = [NSColor colorWithCGColor:cgcolor];
    CGColorRelease(cgcolor);
    return result;
}

- (CGFloat)prc_perceivedBrightness
{
    CGFloat r, g, b, a;

    [self getRed:&r green:&g blue:&b alpha:&a];

    CGFloat brightness = PRCPerceivedBrightnessInvalid;
    if (a > 0.01) { // 不透明度大于0.01即算是不透明
        brightness = 0.2126 * r + 0.7152 * g + 0.0722 * b; // ITU-R BT.709
    }

    return brightness;
}

- (BOOL)prc_prefersLightContent
{
    CGFloat brightness = [self prc_perceivedBrightness];
    if (brightness == PRCPerceivedBrightnessInvalid) {
        return NO;
    }
    return brightness < 0.8;
}

@end

@implementation NSColor (PRCStyleColor)

+ (NSColor *)prc_noticeColor
{
    return [self prc_colorWithRGBString:@"#B92BA0"];
}

@end