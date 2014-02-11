//
//  CrumbBannerAdView.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Underscore.m/Underscore.h>
#import <AsyncImageView/AsyncImageView.h>

@interface CrumbBannerAdView : UIView

-(instancetype)initWithCrumbAd:(NSDictionary *)adData
               withTapDelegate:(id)tapDelegate
                 withTapAction:(SEL)tapAction;

-(void)hideAd;
-(void)unhideAd;

@end
