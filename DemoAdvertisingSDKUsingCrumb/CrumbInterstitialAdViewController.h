//
//  CrumbInterstitialAdViewController.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BButton/BButton.h>
#import <AsyncImageView/AsyncImageView.h>

@interface CrumbInterstitialAdViewController : UIViewController

@property (nonatomic) NSInteger index;

- (instancetype)initWithRetailerName:(NSString *)retailerName
                         product:(NSDictionary *)productData
        cancelButtonTarget:(id)cancelButtonPressedTarget
              buttonAction:(SEL)cancelButtonPressedAction;

@end
