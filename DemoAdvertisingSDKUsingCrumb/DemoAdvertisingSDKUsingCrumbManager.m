//
//  DemoAdvertisingSDKUsingCrumbManager.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "DemoAdvertisingSDKUsingCrumbManager.h"


@interface DemoAdvertisingSDKUsingCrumbManager()

@property (nonatomic, strong) NSTimer *adRefreshTimer;
@property (nonatomic) NSInteger bannerAdTimeInterval;

@end


@implementation DemoAdvertisingSDKUsingCrumbManager

+ (instancetype)getAdManager {
    static DemoAdvertisingSDKUsingCrumbManager *sharedAdManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAdManager = [[self alloc] init];
    });
    return sharedAdManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _bannerAdTimeInterval = CRUMB_BANNER_AD_DEFAULT_INTERVAL;
    }
    return self;
}

-(void)setBannerAdDisplayInterval:(NSInteger)seconds{
    self.bannerAdTimeInterval = seconds;
    if (self.adRefreshTimer && [self.adRefreshTimer isValid]) {
        [self stopDisplayingBannerAds];
        [self startDisplayingBannerAds];
    }
}

-(void)startDisplayingBannerAds{
    self.adRefreshTimer = [NSTimer timerWithTimeInterval:self.bannerAdTimeInterval
                                                  target:self
                                                selector:@selector(fetchAndDisplayNewCrumbAd:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.adRefreshTimer forMode:NSDefaultRunLoopMode];
}

-(void)stopDisplayingBannerAds{
    [self.adRefreshTimer invalidate];
}

-(void)fetchAndDisplayNewCrumbAd:(NSTimer *) theTimer
{
    NSLog(@"Timer fired");
    [[DemoAdSDKUsingCrumbNetworkManager getDemoAdSDKUsingCrumbNetworkManager] fetchAdvertisement];
}


#pragma mark - CrumbAdFetchDelegate methods

-(void)fetchedAdFromCrumb:(NSDictionary *)ad{
    NSLog(@"Crumb Ad fetched :\n%@", ad);
    [[DemoAdSDKUsingCrumbUIManager getDemoAdSDKUsingCrumbUIManager] createBannerAdAndDisplayOnScreen:ad];
}

-(void)noAdInventoryAvailableOnCrumb{
    NSLog(@"No Crumb ad inventory available");
    [[DemoAdSDKUsingCrumbUIManager getDemoAdSDKUsingCrumbUIManager] createBannerAdAndDisplayOnScreen:nil];
}

-(void)errorFetchingAdFromCrumb:(NSError *)error{
    NSLog(@"Error fetching ad from crumb :\n%@", error);
    [[DemoAdSDKUsingCrumbUIManager getDemoAdSDKUsingCrumbUIManager] createBannerAdAndDisplayOnScreen:nil];
}


#pragma mark - CrumbInterstitialAdDisplayDelegate methods

-(void)startedDisplayingInterstitialAd{
    [self stopDisplayingBannerAds];
}

-(void)userClosedInterstitialAd{
    [self startDisplayingBannerAds];
}

@end
