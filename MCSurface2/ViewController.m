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
    
    // Constraints
    LabelSquare * c1 = [[LabelSquare alloc] init];
    [c1 setViewportFrame:CGRectMake(100, 100, 100, 100) atContentOffset:CGPointMake(0, 0)];
    c1.zIndex = 20000;
    c1.text = @"A";
    c1.color = [UIColor grayColor];
    
    [c1 addConstraint:[[MCSurfaceConstraint alloc] initWithValue:100 position:MCSurfaceConstraintPosition_Left reference:MCSurfaceConstraintReference_Viewport]];
    [c1 addConstraint:[[MCSurfaceConstraint alloc] initWithValue:720 position:MCSurfaceConstraintPosition_Right reference:MCSurfaceConstraintReference_Surface]];

    [items addObject:c1];
    
    LabelSquare * c2 = [[LabelSquare alloc] init];
    [c2 setViewportFrame:CGRectMake(100, 100, 100, 100) atContentOffset:CGPointMake(640, 0)];
    c2.zIndex = 20000;
    c2.text = @"B";
    c2.color = [UIColor grayColor];
    
    [c2 addConstraint:[[MCSurfaceConstraint alloc] initWithValue:100 position:MCSurfaceConstraintPosition_Left reference:MCSurfaceConstraintReference_Viewport]];
    [c2 addConstraint:[[MCSurfaceConstraint alloc] initWithValue:1040 position:MCSurfaceConstraintPosition_Right reference:MCSurfaceConstraintReference_Surface]];
    
    [items addObject:c2];
    
    LabelSquare * c3 = [[LabelSquare alloc] init];
    [c3 setViewportFrame:CGRectMake(100, 100, 100, 100) atContentOffset:CGPointMake(960, 0)];
    c3.zIndex = 20000;
    c3.text = @"B";
    c3.color = [UIColor grayColor];
    
    [c3 addConstraint:[[MCSurfaceConstraint alloc] initWithValue:100 position:MCSurfaceConstraintPosition_Left reference:MCSurfaceConstraintReference_Viewport]];
    
    [items addObject:c3];
    
    _surface.items = items;
    _surface.contentSize = CGSizeMake(_surface.bounds.size.width * 5, 460 * 2);
    _surface.directionalLockEnabled = YES;
    _surface.pagingEnabled = YES;
    
    _surface.restorationIdentifier = @"MainSurface";
    
}

@end