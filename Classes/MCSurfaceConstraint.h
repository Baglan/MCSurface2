//
//  MCSurfaceConstraint.h
//  MCSurface2
//
//  Created by Baglan on 9/19/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum MCSurfaceConstraintPosition {
    MCSurfaceConstraintPosition_Left,
    MCSurfaceConstraintPosition_Top,
    MCSurfaceConstraintPosition_Right,
    MCSurfaceConstraintPosition_Bottom
};

enum MCSurfaceConstraintReference {
    MCSurfaceConstraintReference_Viewport,
    MCSurfaceConstraintReference_Surface
};

@interface MCSurfaceConstraint : NSObject

@property (nonatomic, assign) enum MCSurfaceConstraintPosition position;
@property (nonatomic, assign) enum MCSurfaceConstraintReference reference;
@property (nonatomic, assign) CGFloat value;

- (id)initWithValue:(CGFloat)value position:(enum MCSurfaceConstraintPosition)position reference:(enum MCSurfaceConstraintReference)reference;
- (CGRect)adjustedFrame:(CGRect)frame forContentOffset:(CGPoint)contentOffset;

@end
