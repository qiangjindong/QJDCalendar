//
//  UIView+QJDRoundRect.m
//  0124-日历周历切换
//
//  Created by 强进冬 on 2018/1/24.
//  Copyright © 2018年 强进冬. All rights reserved.
//

#import "UIView+QJDRoundRect.h"

@implementation UIView (QJDRoundRect)

- (instancetype)qjd_roundCornerWith:(CGFloat)cornerRadius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
    
    return self;
}

@end
