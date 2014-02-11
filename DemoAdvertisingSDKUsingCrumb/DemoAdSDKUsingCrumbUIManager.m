//
//  DemoAdSDKUsingCrumbUIManager.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "DemoAdSDKUsingCrumbUIManager.h"

@interface DemoAdSDKUsingCrumbUIManager() <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSDictionary *crumbAdData;

@property (nonatomic, strong) UIView *bannerAdView;

@property (nonatomic, strong) UIPageViewController *interstitialAdViewController;
@property (nonatomic, strong) NSArray *interstitialAdViewControllers;

@end


@implementation DemoAdSDKUsingCrumbUIManager

+ (instancetype)getDemoAdSDKUsingCrumbUIManager {
    static DemoAdSDKUsingCrumbUIManager *sharedDemoAdSDKUsingCrumbUIManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDemoAdSDKUsingCrumbUIManager = [[self alloc] init];
    });
    return sharedDemoAdSDKUsingCrumbUIManager;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

-(UIPageViewController *)interstitialAdViewController{
    if (!_interstitialAdViewController){
        _interstitialAdViewController =
        [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                      options:nil];
        _interstitialAdViewController.dataSource = self;
        [_interstitialAdViewController.view setFrame:[self getVisibleViewController].view.bounds];
    }
    return _interstitialAdViewController;
}

-(void)createInterstitialAdAndDisplayOnScreen{
    self.interstitialAdViewControllers =
    Underscore.array([self.crumbAdData valueForKey:@"products"])
    .map(^(NSDictionary *product){
        return [[CrumbInterstitialAdViewController alloc] initWithRetailerName:[self.crumbAdData valueForKey:@"retailer"]
                                                                       product:product
                                                            cancelButtonTarget:self
                                                                  buttonAction:@selector(interstitialAdClosed)];
    }).unwrap;
    
    [self.interstitialAdViewController setViewControllers:@[[self.interstitialAdViewControllers firstObject]]
                                                direction:UIPageViewControllerNavigationDirectionForward
                                                 animated:YES
                                               completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getVisibleViewController] addChildViewController:self.interstitialAdViewController];
        [[self getVisibleViewController].view addSubview:self.interstitialAdViewController.view];
        [self.interstitialAdViewController didMoveToParentViewController:[self getVisibleViewController]];
        [[DemoAdvertisingSDKUsingCrumbManager getAdManager] startedDisplayingInterstitialAd];
    });
}

-(void)removeInterstitialAdFromScreen{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.interstitialAdViewController.view removeFromSuperview];
        [self.interstitialAdViewController removeFromParentViewController];
    });
}

-(void)createBannerAdAndDisplayOnScreen:(NSDictionary *)adData{
    self.crumbAdData = adData;
    if (self.bannerAdView) {
        [self minimizeCurrentBannerAdWithCompletionCallback:^{
            [self createAndMaximizeNewBannerAdWithAdData];
        }];
    }else{
        [self createAndMaximizeNewBannerAdWithAdData];
    }
}

-(void)minimizeCurrentBannerAdWithCompletionCallback:(void (^)(void))completionCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect minimizedBannerAdFrame = self.bannerAdView.frame;
        minimizedBannerAdFrame.origin.y += self.bannerAdView.bounds.size.height;
        [UIView animateWithDuration:CRUMB_BANNER_AD_CLOSE_ANIMATION_DURATION
                         animations:^{
                             self.bannerAdView.frame = minimizedBannerAdFrame;
                         }
                         completion:^(BOOL finished) {
                             [self.bannerAdView removeFromSuperview];
                             completionCallback();
                         }];
    });
}

-(void)createAndMaximizeNewBannerAdWithAdData{
    UIView *parentView = [self getVisibleViewController].view;
    if (!self.crumbAdData) {
        self.bannerAdView = [[RandomBannerAdView alloc] init];
    }else{
        self.bannerAdView = [[CrumbBannerAdView alloc] initWithCrumbAd:self.crumbAdData
                                                       withTapDelegate:self
                                                         withTapAction:@selector(bannerAdTapped)];
    }
    [parentView addSubview:self.bannerAdView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bannerAdView setNeedsDisplay];
        
        CGRect maximizedBannerAdFrame = self.bannerAdView.frame;
        maximizedBannerAdFrame.origin.y -= self.bannerAdView.bounds.size.height;
        [UIView animateWithDuration:CRUMB_BANNER_AD_OPEN_ANIMATION_DURATION animations:^{
            self.bannerAdView.frame = maximizedBannerAdFrame;
        }];
    });
}

-(void)bannerAdTapped{
    NSLog(@"Banner Ad tapped");
    dispatch_async(dispatch_get_main_queue(), ^{
        [((CrumbBannerAdView *)self.bannerAdView) hideAd];
        [self.bannerAdView setNeedsDisplay];
    });
    [self createInterstitialAdAndDisplayOnScreen];
}

-(void)interstitialAdClosed{
    NSLog(@"Interstitial Ad closed");
    [self removeInterstitialAdFromScreen];
    dispatch_async(dispatch_get_main_queue(), ^{
        [((CrumbBannerAdView *)self.bannerAdView) unhideAd];
        [self.bannerAdView setNeedsDisplay];
    });
    [self minimizeCurrentBannerAdWithCompletionCallback:^{
        [[DemoAdvertisingSDKUsingCrumbManager getAdManager] userClosedInterstitialAd];
    }];
}


#pragma mark - methods to get dependent app's visible view controller

- (UIViewController *)getVisibleViewController{
    return [self getVisibleViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)getVisibleViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController
         isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController =
        (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController =
        [[navigationController viewControllers] lastObject];
        return [self getVisibleViewController:lastViewController];
    }
    
    UIViewController *presentedViewController =
    (UIViewController *)rootViewController.presentedViewController;
    return [self getVisibleViewController:presentedViewController];
}


#pragma mark - UIPageViewControllerDataSource methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger indexOfCurrentViewController = [self.interstitialAdViewControllers indexOfObject:viewController];
    indexOfCurrentViewController++;
    if (indexOfCurrentViewController == [self.interstitialAdViewControllers count]) {
        return nil;
    }
    return [self.interstitialAdViewControllers objectAtIndex:indexOfCurrentViewController];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger indexOfCurrentViewController = [self.interstitialAdViewControllers indexOfObject:viewController];
    if (indexOfCurrentViewController == 0) {
        return nil;
    }
    indexOfCurrentViewController--;
    return [self.interstitialAdViewControllers objectAtIndex:indexOfCurrentViewController];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [[self.crumbAdData valueForKey:@"products"] count] ;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
