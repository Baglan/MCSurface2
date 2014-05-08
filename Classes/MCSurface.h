//
//  MCSurfaceScrollView.h
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/5/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSurfaceItem;

@interface MCSurface : UIScrollView

@property (nonatomic, readonly) BOOL scrolling;

@property (nonatomic, retain) NSArray * items;

- (UIView *)dequeueViewForItem:(MCSurfaceItem *)item;

- (void)storeReusableViewController:(UIViewController *)controller;
- (UIViewController *)storedReusableViewControllerForView:(UIView *)view;

@end
