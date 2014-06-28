//
//  MCSurface+Convenience.h
//  MCSurface2
//
//  Created by Baglan on 6/28/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "MCSurface.h"

@interface MCSurface (Convenience)

@property (nonatomic, assign) NSInteger verticalPage;
@property (nonatomic, assign) NSInteger horizontalPage;
@property (nonatomic, assign) NSInteger page;   // Alias for horizontalPage

- (void)setHorizontalPage:(NSInteger)horizontalPage verticalPage:(NSInteger)verticalPage animated:(BOOL)animated;
- (void)setVerticalPage:(NSInteger)verticalPage animated:(BOOL)animated;
- (void)setHorizontalPage:(NSInteger)horizontalPage animated:(BOOL)animated;
- (void)setPage:(NSInteger)page animated:(BOOL)animated;

- (void)snapToNearestPage;
- (void)snapToNearestPageAnimated:(BOOL)animated;

@end
