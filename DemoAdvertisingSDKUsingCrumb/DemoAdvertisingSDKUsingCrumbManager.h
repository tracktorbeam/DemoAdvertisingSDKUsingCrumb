//
//  DemoAdvertisingSDKUsingCrumbManager.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CrumbAdFetchDelegate.h"
#import "CrumbInterstitialAdDisplayDelegate.h"
#import "DemoAdSDKUsingCrumbUIManager.h"
#import "DemoAdSDKUsingCrumbNetworkManager.h"
#import "DemoAdSDKUsingCrumbConstants.h"

@interface DemoAdvertisingSDKUsingCrumbManager : NSObject <CrumbAdFetchDelegate, CrumbInterstitialAdDisplayDelegate>

+(instancetype)getAdManager;

-(void)setBannerAdDisplayInterval:(NSInteger)seconds;

-(void)startDisplayingBannerAds;

-(void)stopDisplayingBannerAds;

@end
