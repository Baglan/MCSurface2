//
//  MCSurfaceViewControllerItem.m
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/6/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurfaceViewControllerItem.h"

@implementation MCSurfaceViewControllerItem

- (UIViewController *)newViewControllerForSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
    return nil;
}

- (UIView *)newViewForSurface:(MCSurface *)surface
{
    UIViewController * viewController = [self newViewControllerForSurface:surface];
    [surface storeReusableViewController:viewController];
    return viewController.view;
}

- (void)prepareView:(UIView *)view forSurface:(MCSurface *)surface
{
    UIViewController * viewController = [surface storedReusableViewControllerForView:view];
    [self prepareViewController:viewController forSurface:surface];
    
    [super prepareView:view forSurface:surface];
}

- (void)prepareViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
}

- (void)updateView:(UIView *)view forSurface:(MCSurface *)surface
{
    UIViewController * viewController = [surface storedReusableViewControllerForView:view];
    [self updateViewController:viewController forSurface:surface];
    
    [super updateView:view forSurface:surface];
}

- (void)updateViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
}

- (void)didPresentView:(UIView *)view forSurface:(MCSurface *)surface
{
    UIViewController * viewController = [surface storedReusableViewControllerForView:view];
    [self didPresentViewController:viewController forSurface:surface];
    
    [super didPresentView:view forSurface:surface];
}

- (void)didDismissView:(UIView *)view forSurface:(MCSurface *)surface
{
    UIViewController * viewController = [surface storedReusableViewControllerForView:view];
    [self didDismissViewController:viewController forSurface:surface];
    
    [super didDismissView:view forSurface:surface];
}

- (void)didPresentViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
}

- (void)didDismissViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface
{
    // To be implemented by extending classes
}

@end
