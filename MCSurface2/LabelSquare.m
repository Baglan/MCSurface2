//
//  LabelSquare.m
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/6/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "LabelSquare.h"
#import "LabelSquareViewController.h"

@implementation LabelSquare

- (UIViewController *)newViewControllerForSurface:(MCSurface *)surface
{
    return [[LabelSquareViewController alloc] initWithNibName:nil bundle:nil];
}

- (void)prepareViewController:(UIViewController *)viewController forSurface:(MCSurface *)surface
{
    LabelSquareViewController * vc = (LabelSquareViewController *)viewController;
    vc.text = self.text;
    vc.view.backgroundColor = self.color;
}

@end
