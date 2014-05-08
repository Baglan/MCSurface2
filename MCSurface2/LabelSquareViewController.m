//
//  LabelSquareViewController.m
//  UICollectioViewExperiments
//
//  Created by Baglan on 5/6/14.
//  Copyright (c) 2014 MobileCreators. All rights reserved.
//

#import "LabelSquareViewController.h"
#import "MCButtonView.h"

@interface LabelSquareViewController ()

@end

@implementation LabelSquareViewController {
    __weak IBOutlet UILabel *_label;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _label.text = text;
}

- (NSString *)text
{
    return _label.text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [MCButtonView wrapView:_label block:^{
        NSLog(@"--- %@", self.text);
    }];
}

@end
