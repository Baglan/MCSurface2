//
//  MCSurface+Convenience.m
//  MCSurface2
//
//  Created by Baglan on 6/28/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurface.h"
#import "MCSurface+Convenience.h"

@implementation MCSurface (Convenience)

- (void)setHorizontalPage:(NSInteger)horizontalPage verticalPage:(NSInteger)verticalPage animated:(BOOL)animated
{
    CGSize pageSize = self.pageSize;
    CGRect rect = self.bounds;
    rect.origin = CGPointMake(pageSize.width * horizontalPage, pageSize.height * verticalPage);
    [self scrollRectToVisible:rect animated:animated];
}

- (void)setHorizontalPage:(NSInteger)horizontalPage animated:(BOOL)animated
{
    CGSize pageSize = self.pageSize;
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = pageSize.width * horizontalPage;
    [self setContentOffset:contentOffset animated:animated];
}

- (void)setVerticalPage:(NSInteger)verticalPage animated:(BOOL)animated
{
    CGSize pageSize = self.pageSize;
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = pageSize.height * verticalPage;
    [self setContentOffset:contentOffset animated:animated];
}

- (void)setHorizontalPage:(NSInteger)horizontalPage
{
    [self setHorizontalPage:horizontalPage animated:NO];
}

- (void)setVerticalPage:(NSInteger)verticalPage
{
    [self setVerticalPage:verticalPage animated:NO];
}

- (NSInteger)horizontalPage
{
    CGSize pageSize = self.pageSize;
    CGPoint contentOffset = self.contentOffset;
    NSUInteger horizontalPage = roundf(contentOffset.x / pageSize.width);
    return horizontalPage;
}

- (NSInteger)verticalPage
{
    CGSize pageSize = self.pageSize;
    CGPoint contentOffset = self.contentOffset;
    NSUInteger verticalPage = roundf(contentOffset.y / pageSize.height);
    return verticalPage;
}

- (NSInteger)page
{
    return self.horizontalPage;
}

- (void)setPage:(NSInteger)page animated:(BOOL)animated
{
    [self setHorizontalPage:page animated:animated];
}

- (void)setPage:(NSInteger)page
{
    [self setPage:page animated:NO];
}

- (void)snapToNearestPageAnimated:(BOOL)animated
{
    [self setHorizontalPage:self.horizontalPage verticalPage:self.verticalPage animated:animated];
}

- (void)snapToNearestPage
{
    [self snapToNearestPageAnimated:NO];
}

@end
