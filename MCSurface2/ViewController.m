//
//  ViewController.m
//  MCSurface2
//
//  Created by Baglan on 5/8/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "ViewController.h"
#import "MCSurface.h"
#import "LabelSquare.h"

@interface ViewController ()

@end

@implementation ViewController {
    __weak IBOutlet MCSurface *_surface;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray * items = [NSMutableArray array];
    
    LabelSquare * firstLabel = [[LabelSquare alloc] init];
    [firstLabel setFrame:CGRectMake(0, 50, 300, 300)];
    firstLabel.zIndex = 10000;
    firstLabel.text = @"First";
    firstLabel.color = [UIColor redColor];
    [items addObject:firstLabel];
    
    LabelSquare * secondLabel = [[LabelSquare alloc] init];
    [secondLabel setFrame:CGRectMake(310, 50, 300, 300)];
    secondLabel.zIndex = 10001;
    secondLabel.text = @"Second";
    secondLabel.color = [UIColor greenColor];
    [items addObject:secondLabel];
    
    LabelSquare * thirdLabel = [[LabelSquare alloc] init];
    // [thirdLabel setFrame:CGRectMake(620, 50, 300, 300)];
    thirdLabel.horizontalParallaxRatio = -1;
    [thirdLabel setViewportFrame:CGRectMake(0, 0, 300, 300) atContentOffset:CGPointMake(320, 460)];
    thirdLabel.zIndex = 10002;
    thirdLabel.text = @"Third";
    thirdLabel.color = [UIColor blueColor];
    // thirdLabel.topViewportBound = -140;
    // thirdLabel.rightViewportBound = 560;
    [items addObject:thirdLabel];
    
    _surface.items = items;
    _surface.contentSize = CGSizeMake(_surface.bounds.size.width * 3, 460 * 2);
    _surface.directionalLockEnabled = YES;
    _surface.pagingEnabled = YES;
    
    _surface.restorationIdentifier = @"MainSurface";
    
}

@end