//
//  MCSurfaceLayoutItem.m
//  UICollectioViewExperiments
//
//  Created by Baglan on 4/24/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurfaceItem.h"
#import "MCSurface.h"
#import <QuartzCore/QuartzCore.h>

@implementation MCSurfaceItem {
    CGPoint _center;
    CGSize _size;
    
    CGFloat _minCenterTop;
    CGFloat _minCenterLeft;
    CGFloat _maxCenterRight;
    CGFloat _maxCenterBottom;
}

- (void)calculateRelatedValues
{
    CGFloat halfWidth = _size.width / 2;
    CGFloat halfHeight = _size.height / 2;
    
    _minCenterTop = -CGFLOAT_MAX + halfHeight;
    _minCenterLeft = -CGFLOAT_MAX + halfWidth;
    _maxCenterRight = CGFLOAT_MAX - halfWidth;
    _maxCenterBottom = CGFLOAT_MAX - halfHeight;
}

#pragma mark - Frame, center, bounds and size

- (void)setViewportFrame:(CGRect)frame atContentOffset:(CGPoint)contentOffset
{
    frame.origin.x -= contentOffset.x * (1 - self.horizontalParallaxRatio);
    frame.origin.y -= contentOffset.y * (1 - self.verticalParallaxRatio);
    [self setFrame:frame];
}

- (void)setFrame:(CGRect)frame
{
    _size = frame.size;
    _center = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
    [self calculateRelatedValues];
}

- (CGRect)frameForSurface:(MCSurface *)surface
{
    CGPoint center = [self centerForSurface:surface];
    return CGRectMake(center.x - _size.width / 2, center.y - _size.height / 2, _size.width, _size.height);
}

- (CGPoint)centerForSurface:(MCSurface *)surface
{
    CGPoint contentOffset = surface.contentOffset;
    CGPoint center = _center;
    
    // Calculate parallax
    center.x -= contentOffset.x * self.horizontalParallaxRatio;
    center.y -= contentOffset.y * self.verticalParallaxRatio;
    
    // Apply bounds
    center.x = center.x < _minCenterLeft + contentOffset.x ? _minCenterLeft + contentOffset.x : center.x;
    center.y = center.y < _minCenterTop + contentOffset.y ? _minCenterTop + contentOffset.y : center.y;
    center.x = center.x > _maxCenterRight + contentOffset.x ? _maxCenterRight + contentOffset.x : center.x;
    center.y = center.y > _maxCenterBottom + contentOffset.y ? _maxCenterBottom + contentOffset.y : center.y;
    
    return center;
}

#pragma mark -

- (UIView *)newViewForSurface:(MCSurface *)surface
{
    return nil;
}

- (UIView *)viewForSurface:(MCSurface *)surface
{
    UIView * view = [surface dequeueViewForItem:self];
    if (!view) {
        view = [self newViewForSurface:surface];
        [surface addSubview:view];
    }
    
    view.transform = CGAffineTransformIdentity;
    view.hidden = NO;
    view.layer.zPosition = self.zIndex;
    
    [self prepareView:view forSurface:surface];
    
    return view;
}

- (void)prepareView:(UIView *)view forSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
}

- (void)updateView:(UIView *)view forSurface:(MCSurface *)surface
{
    view.frame = [self frameForSurface:surface];
}

#pragma mark - Viewport bounds

- (void)setTopViewportBound:(CGFloat)topViewportBound
{
    _minCenterTop = topViewportBound + _size.height / 2;
}

- (CGFloat)topViewportBound
{
    return _minCenterTop - _size.height / 2;
}

- (void)setLeftViewportBound:(CGFloat)leftViewportBound
{
    _minCenterLeft = leftViewportBound + _size.width / 2;
}

- (CGFloat)leftViewportBound
{
    return _minCenterLeft - _size.width / 2;
}

- (void)setRightViewportBound:(CGFloat)rightViewportBound
{
    _maxCenterRight = rightViewportBound - _size.width / 2;
}

- (CGFloat)rightViewportBound
{
    return _maxCenterRight + _size.width / 2;
}

- (void)setBottomViewportBound:(CGFloat)bottomViewportBound
{
    _maxCenterBottom = bottomViewportBound - _size.height / 2;
}

- (CGFloat)bottomViewportBound
{
    return _maxCenterBottom + _size.height / 2;
}

@end
