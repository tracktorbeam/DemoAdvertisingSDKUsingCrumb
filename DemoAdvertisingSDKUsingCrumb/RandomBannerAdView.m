//
//  RandomBannerAdView.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "RandomBannerAdView.h"


@implementation RandomBannerAdView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 568, 320, 50)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        mainLabel.textAlignment = NSTextAlignmentCenter;
        mainLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:20];
        mainLabel.text = @"Random Ad";
        [self addSubview:mainLabel];
    }
    return self;
}


@end
