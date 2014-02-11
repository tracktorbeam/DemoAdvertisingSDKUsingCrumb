//
//  DemoAdSDKUsingCrumbUIManager.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Underscore.m/Underscore.h> 

#import "DemoAdvertisingSDKUsingCrumbManager.h"
#import "CrumbBannerAdView.h"
#import "RandomBannerAdView.h"
#import "CrumbInterstitialAdViewController.h"


@interface DemoAdSDKUsingCrumbUIManager : NSObject

+ (instancetype)getDemoAdSDKUsingCrumbUIManager;

-(void)createBannerAdAndDisplayOnScreen:(NSDictionary *)adData;

@end
