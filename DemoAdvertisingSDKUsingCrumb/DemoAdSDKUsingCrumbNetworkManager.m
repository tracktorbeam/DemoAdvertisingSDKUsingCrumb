//
//  DemoAdSDKUsingCrumbNetworkManager.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "DemoAdSDKUsingCrumbNetworkManager.h"

@interface DemoAdSDKUsingCrumbNetworkManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *crumbNetworkManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *imageFetchingManager;

@end


@implementation DemoAdSDKUsingCrumbNetworkManager

+ (instancetype)getDemoAdSDKUsingCrumbNetworkManager {
    static DemoAdSDKUsingCrumbNetworkManager *sharedDemoAdSDKUsingCrumbNetworkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDemoAdSDKUsingCrumbNetworkManager = [[self alloc] init];
    });
    return sharedDemoAdSDKUsingCrumbNetworkManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _crumbNetworkManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:CRUMB_BACKEND_AD_URL]];
    }
    return self;
}

- (void)fetchAdvertisement{
    [self.crumbNetworkManager GET:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!responseObject) {
            [[DemoAdvertisingSDKUsingCrumbManager getAdManager] noAdInventoryAvailableOnCrumb];
        }else{
            [[DemoAdvertisingSDKUsingCrumbManager getAdManager] fetchedAdFromCrumb:(NSDictionary *)responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[DemoAdvertisingSDKUsingCrumbManager getAdManager] errorFetchingAdFromCrumb:error];
    }];
}

@end
