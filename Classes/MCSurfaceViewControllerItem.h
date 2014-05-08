//
//  MCSurfaceViewControllerItem.h
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/6/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurfaceItem.h"

@interface MCSurfaceViewControllerItem : MCSurfaceItem

- (UIViewController *)newViewControllerForSurface:(MCSurface *)surface;
- (void)prepareViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface;
- (void)updateViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface;

@end
