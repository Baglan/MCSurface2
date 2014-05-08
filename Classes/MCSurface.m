//
//  MCSurfaceScrollView.m
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/5/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurface.h"
#import "MCSurfaceItem.h"
#import <objc/runtime.h>

BOOL protocol_hasSelector(Protocol *protocol, SEL aSelector)
{
    struct objc_method_description method;
    
    method = protocol_getMethodDescription(protocol, aSelector, YES, YES);
    if (method.name || method.types) {
        return YES;
    }
    
    method = protocol_getMethodDescription(protocol, aSelector, YES, NO);
    if (method.name || method.types) {
        return YES;
    }
    
    method = protocol_getMethodDescription(protocol, aSelector, NO, YES);
    if (method.name || method.types) {
        return YES;
    }
    
    method = protocol_getMethodDescription(protocol, aSelector, NO, NO);
    if (method.name || method.types) {
        return YES;
    }
    
    return NO;
}

enum MCSurface_ScrollDirection {
    MCSurface_ScrollDirectionUndecided = 0,
    MCSurface_ScrollDirectionVertical,
    MCSurface_ScrollDirectionHorizontal
};

@interface MCSurface () <UIScrollViewDelegate>

@end

@implementation MCSurface {
    NSMutableDictionary * _reusableViews;
    
    NSMutableSet * _currentItems;
    NSMutableDictionary * _currentViews;
    
    enum MCSurface_ScrollDirection _scrollDirection;
    CGPoint _initialContentOffset;
    
    NSMutableSet * _controllers;
    
    id<UIScrollViewDelegate> _subDelegate;
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setup
{
    _reusableViews = [NSMutableDictionary dictionary];
    
    _currentItems = [NSMutableSet set];
    _currentViews = [NSMutableDictionary dictionary];
    
    [self scrollingEnded];
    
    _controllers = [NSMutableSet set];
    
    [super setDelegate:self];
}

#pragma mark - Delegate and Subdelegate

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    _subDelegate = delegate;
}

- (BOOL)respondsToSelector:(SEL)aSelector;
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    if (protocol_hasSelector(@protocol(UIScrollViewDelegate), aSelector) && _subDelegate && [_subDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector;
{
    if (_subDelegate && protocol_hasSelector(@protocol(UIScrollViewDelegate), aSelector)) {
        return _subDelegate;
    }
    
    return nil;
}

#pragma mark - Handling own delegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollDirection = MCSurface_ScrollDirectionUndecided;
    _initialContentOffset = self.contentOffset;
    
    if (_subDelegate && [_subDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_subDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollingEnded
{
    _scrollDirection = MCSurface_ScrollDirectionUndecided;
    _scrolling = NO;
    
    // Re-order subviews by layer zPosition
    // This is necessary to preserve the correct responder chain
    NSArray * sortedViews = [_currentViews.allValues sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UIView * a = obj1;
        UIView * b = obj2;
        return a.layer.zPosition > b.layer.zPosition ? NSOrderedDescending : (a.layer.zPosition < b.layer.zPosition ? NSOrderedAscending : NSOrderedSame);
    }];
    
    [sortedViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView * view = obj;
        [self bringSubviewToFront:view];
    }];
        
    [self setNeedsLayout];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollingEnded];
    
    if (_subDelegate && [_subDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_subDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollingEnded];
    
    if (_subDelegate && [_subDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_subDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollingEnded];
    }
    
    if (_subDelegate && [_subDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_subDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_scrolling) {
        _scrolling = YES;
    }
    
    if (self.directionalLockEnabled) {
        if (self.dragging && _scrollDirection == MCSurface_ScrollDirectionUndecided) {
            CGPoint contentOffset = scrollView.contentOffset;
            double deltaX = fabs(contentOffset.x - _initialContentOffset.x);
            double deltaY = fabs(contentOffset.y - _initialContentOffset.y);
            
            if (deltaX > deltaY) {
                _scrollDirection = MCSurface_ScrollDirectionHorizontal;
            } else {
                _scrollDirection = MCSurface_ScrollDirectionVertical;
            }
        }
        
        // Compensate for direction lock
        if (_scrollDirection == MCSurface_ScrollDirectionHorizontal) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, _initialContentOffset.y);
        }
        
        if (_scrollDirection == MCSurface_ScrollDirectionVertical) {
            scrollView.contentOffset = CGPointMake(_initialContentOffset.x, scrollView.contentOffset.y);
        }
    }
    
    [self setNeedsLayout];
    
    if (_subDelegate && [_subDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_subDelegate scrollViewDidScroll:scrollView];
    }
}

#pragma mark - Items

- (void)setItems:(NSArray *)items
{
    NSUInteger index = 0;
    for (MCSurfaceItem * item in items) {
        item.indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        index++;
    }
    
    _items = items;
    
    [self setNeedsLayout];
}

#pragma mark - Recycling views

- (void)enqueueView:(UIView *)view withReuseIdentifier:(NSString *)reuseIdentifier
{
    NSMutableSet * views = _reusableViews[reuseIdentifier];
    if (!views) {
        views = [NSMutableSet set];
    }
    [views addObject:view];
    _reusableViews[reuseIdentifier] = views;
}

- (UIView *)dequeueViewWithReuseIdentifier:(NSString *)reuseIdentifier
{
    NSMutableSet * views = _reusableViews[reuseIdentifier];
    if (views) {
        UIView *view = [views anyObject];
        if (view) {
            [views removeObject:view];
            _reusableViews[reuseIdentifier] = views;
            return view;
        }
    }
    return nil;
}

- (UIView *)dequeueViewForItem:(MCSurfaceItem *)item
{
    return [self dequeueViewWithReuseIdentifier:NSStringFromClass([item class])];
}

#pragma mark - Recycling controllers

- (void)storeReusableViewController:(UIViewController *)controller
{
    [_controllers addObject:controller];
}

- (UIViewController *)storedReusableViewControllerForView:(UIView *)view
{
    for (UIViewController * controller in _controllers) {
        if (controller.view == view) {
            return controller;
        }
    }
    return nil;
}

#pragma mark - Content offset

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    if (animated) {
        _scrolling = YES;
    }
    
    [super setContentOffset:contentOffset animated:animated];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    CGRect visibleRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height);
    
    NSMutableSet * visible = [NSMutableSet set];
    for (MCSurfaceItem * item in self.items) {
        if (CGRectIntersectsRect([item frameForSurface:self], visibleRect)) {
            [visible addObject:item];
        }
    }
    
    NSMutableSet * itemsToRemove = [NSMutableSet setWithSet:_currentItems];
    [itemsToRemove minusSet:visible];
    
    NSMutableSet * itemsToAdd = [NSMutableSet setWithSet:visible];
    [itemsToAdd minusSet:_currentItems];
    
    for (MCSurfaceItem * item in itemsToRemove) {
        UIView * view = _currentViews[item.indexPath];
        [self enqueueView:view withReuseIdentifier:NSStringFromClass([item class])];
        [_currentViews removeObjectForKey:item.indexPath];
        [_currentItems removeObject:item];
        view.hidden = YES;
    }
    
    for (MCSurfaceItem * item in itemsToAdd) {
        UIView * view = [item viewForSurface:self];
        [_currentViews setObject:view forKey:item.indexPath];
        [_currentItems addObject:item];
    }
    
    for (MCSurfaceItem * item in visible) {
        UIView * view = _currentViews[item.indexPath];
        [item updateView:view forSurface:self];
    }
    
    [super layoutSubviews];
}

@end
