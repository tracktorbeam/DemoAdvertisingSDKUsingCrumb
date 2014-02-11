//
//  DemoAdSDKUsingCrumbNetworkManager.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AdSupport/AdSupport.h>

#import "DemoAdvertisingSDKUsingCrumbManager.h"


@interface DemoAdSDKUsingCrumbNetworkManager : NSObject

+ (instancetype)getDemoAdSDKUsingCrumbNetworkManager;

- (void)fetchAdvertisement;

@end
