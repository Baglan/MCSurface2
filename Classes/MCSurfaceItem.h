//
//  MCSurfaceLayoutItem.h
//  UICollectioViewExperiments
//
//  Created by Baglan on 4/24/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCSurface.h"
#import "MCSurfaceConstraint.h"

@interface MCSurfaceItem : NSObject

@property (nonatomic, retain) NSIndexPath * indexPath;
@property (nonatomic, assign) NSInteger zIndex;
@property (nonatomic, assign) CGFloat verticalParallaxRatio;
@property (nonatomic, assign) CGFloat horizontalParallaxRatio;

@property (nonatomic, assign) CGFloat topViewportBound;
@property (nonatomic, assign) CGFloat leftViewportBound;
@property (nonatomic, assign) CGFloat rightViewportBound;
@property (nonatomic, assign) CGFloat bottomViewportBound;

@property (nonatomic, readonly) NSMutableArray * constraints;

@property (nonatomic, readonly) BOOL visible;

- (void)setViewportFrame:(CGRect)frame atContentOffset:(CGPoint)contentOffset;
- (void)setFrame:(CGRect)frame;
- (CGRect)frameForSurface:(MCSurface *)surface;

- (UIView *)newViewForSurface:(MCSurface *)surface;
- (UIView *)viewForSurface:(MCSurface *)surface;
- (void)prepareView:(UIView *)view forSurface:(MCSurface *)surface;
- (void)updateView:(UIView *)view forSurface:(MCSurface *)surface;

- (void)itemDidBecomeVisibleForSurface:(MCSurface *)surface;
- (void)itemDidBecomeInisibleForSurface:(MCSurface *)surface;

- (void)addConstraint:(MCSurfaceConstraint *)constraint;

@end
