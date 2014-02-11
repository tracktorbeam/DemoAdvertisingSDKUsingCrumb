//
//  DemoAdSDKUsingCrumb.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/10/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "DemoAdSDKUsingCrumb.h"
#import "DemoAdvertisingSDKUsingCrumbManager.h"

@implementation DemoAdSDKUsingCrumb

+ (void)startDisplayingAdsWithFrequency:(NSInteger)seconds{
    DemoAdvertisingSDKUsingCrumbManager *adManager = [DemoAdvertisingSDKUsingCrumbManager getAdManager];
    [adManager setBannerAdDisplayInterval:seconds];
    [adManager startDisplayingBannerAds];
}

+ (void)stopDisplayingAds{
    [[DemoAdvertisingSDKUsingCrumbManager getAdManager] stopDisplayingBannerAds];
}

@end
