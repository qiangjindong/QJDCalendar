//
//  UIView+QJDExtension.m
//  TestClender
//
//  Created by 强进冬 on 2017/12/30.
//  Copyright © 2017年 强进冬. All rights reserved.
//

#import "UIView+QJDExtension.h"

@implementation UIView (QJDExtension)

- (void)setQjd_size:(CGSize)qjd_size{
    CGRect frame = self.frame;
    frame.size = qjd_size;
    self.frame = frame;
}
- (CGSize)qjd_size {
    return self.frame.size;
}

- (void)setQjd_x:(CGFloat)qjd_x {
    CGRect frame = self.frame;
    frame.origin.x = qjd_x;
    self.frame = frame;
}
- (CGFloat)qjd_x {
    return self.frame.origin.x;
}

- (void)setQjd_y:(CGFloat)qjd_y {
    CGRect frame = self.frame;
    frame.origin.y = qjd_y;
    self.frame = frame;
}
- (CGFloat)qjd_y {
    return self.frame.origin.y;
}

- (void)setQjd_width:(CGFloat)qjd_width {
    CGRect frame = self.frame;
    frame.size.width = qjd_width;
    self.frame = frame;
}
- (CGFloat)qjd_width {
    return self.frame.size.width;
}

- (void)setQjd_height:(CGFloat)qjd_height {
    CGRect frame = self.frame;
    frame.size.height = qjd_height;
    self.frame = frame;
}
- (CGFloat)qjd_height {
    return self.frame.size.height;
}

- (void)setQjd_centerX:(CGFloat)qjd_centerX {
    CGPoint center = self.center;
    center.x = qjd_centerX;
    self.center = center;
}
- (CGFloat)qjd_centerX {
    return self.center.x;
}

- (void)setQjd_centerY:(CGFloat)qjd_centerY {
    CGPoint center = self.center;
    center.y = qjd_centerY;
    self.center = center;
}
- (CGFloat)qjd_centerY {
    return self.center.y;
}

- (void)setQjd_right:(CGFloat)qjd_right {
    CGRect frame = self.frame;
    frame.size.width = self.qjd_x - qjd_right;
    self.frame = frame;
}
- (CGFloat)qjd_right {
    return self.qjd_x - self.qjd_width;
}

- (void)setQjd_bottom:(CGFloat)qjd_bottom {
    CGRect frame = self.frame;
    frame.size.height = self.qjd_y - qjd_bottom;
    self.frame = frame;
}
- (CGFloat)qjd_bottom {
    return self.qjd_y - self.qjd_height;
}

@end
