//
//  DemoAdSDKUsingCrumb.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/10/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoAdSDKUsingCrumb : NSObject

+ (void)startDisplayingAdsWithFrequency:(NSInteger)seconds;

+ (void)stopDisplayingAds;

@end
