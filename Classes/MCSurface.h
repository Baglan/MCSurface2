//
//  MCSurfaceScrollView.h
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/5/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSurfaceItem;
@protocol MCSurfaceDelegate;

@interface MCSurface : UIView

@property(nonatomic, getter=isDirectionalLockEnabled) BOOL directionalLockEnabled;
@property(nonatomic, getter=isPagingEnabled) BOOL pagingEnabled;
@property (nonatomic) CGSize pageSize;
@property(nonatomic) CGPoint contentOffset;

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;

@property(nonatomic) CGSize contentSize;

@property (nonatomic, readonly) BOOL scrolling;
@property (nonatomic, retain) NSArray * items;

- (UIView *)dequeueViewForItem:(MCSurfaceItem *)item;

- (void)storeReusableViewController:(UIViewController *)controller;
- (UIViewController *)storedReusableViewControllerForView:(UIView *)view;

@property(nonatomic,assign) id<MCSurfaceDelegate> delegate;

@end

@protocol MCSurfaceDelegate <UIScrollViewDelegate>

@optional

- (void)surfaceDidStartScrolling:(MCSurface *)surface;
- (void)surfaceDidFinishScrolling:(MCSurface *)surface;

@end