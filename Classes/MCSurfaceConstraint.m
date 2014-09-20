//
//  MCSurfaceConstraint.m
//  MCSurface2
//
//  Created by Baglan on 9/19/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurfaceConstraint.h"

@implementation MCSurfaceConstraint

- (id)initWithValue:(CGFloat)value position:(enum MCSurfaceConstraintPosition)position reference:(enum MCSurfaceConstraintReference)reference
{
    self = [super init];
    if (self) {
        _value = value;
        _position = position;
        _reference = reference;
    }
    return self;
}

- (CGRect)adjustedFrame:(CGRect)frame forContentOffset:(CGPoint)contentOffset
{
    CGRect adjustedFrame = frame;
    CGFloat value = self.value;
    
    if (self.reference == MCSurfaceConstraintReference_Viewport) {
        switch (self.position) {
            case MCSurfaceConstraintPosition_Left:
            case MCSurfaceConstraintPosition_Right:
                value += contentOffset.x;
                break;
                
            case MCSurfaceConstraintPosition_Top:
            case MCSurfaceConstraintPosition_Bottom:
                value += contentOffset.y;
                break;
                
            default:
                break;
        }
    }
    
    switch (self.position) {
        case MCSurfaceConstraintPosition_Left:
            adjustedFrame.origin.x = adjustedFrame.origin.x < value ? value : adjustedFrame.origin.x;
            break;
            
        case MCSurfaceConstraintPosition_Right:
            adjustedFrame.origin.x = adjustedFrame.origin.x + adjustedFrame.size.width > value ? value - adjustedFrame.size.width : adjustedFrame.origin.x;
            break;
            
        case MCSurfaceConstraintPosition_Top:
            adjustedFrame.origin.y = adjustedFrame.origin.y < value ? value : adjustedFrame.origin.y;
            break;
            
        case MCSurfaceConstraintPosition_Bottom:
            adjustedFrame.origin.y = adjustedFrame.origin.y + adjustedFrame.size.height > value ? value - adjustedFrame.size.height : adjustedFrame.origin.y;
            break;
            
        default:
            break;
    }
    
    return adjustedFrame;
}

@end
