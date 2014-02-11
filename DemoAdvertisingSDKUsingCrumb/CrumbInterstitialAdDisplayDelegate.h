//
//  CrumbInterstitialAdDisplayDelegate.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/10/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CrumbInterstitialAdDisplayDelegate <NSObject>
@required
-(void)startedDisplayingInterstitialAd;
-(void)userClosedInterstitialAd;
@end
