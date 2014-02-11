//
//  CrumbBannerAdView.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "CrumbBannerAdView.h"

@interface CrumbBannerAdView()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) NSArray *imageGallery;
@property (nonatomic, strong) UIView *bannerAdTapDetector;
@property (nonatomic, strong) UIView *bannerAdCover;

@end


@implementation CrumbBannerAdView

-(instancetype)initWithCrumbAd:(NSDictionary *)adData
               withTapDelegate:(id)tapDelegate
                 withTapAction:(SEL)tapAction{
    self = [super initWithFrame:CGRectMake(0, 568, 320, 50)];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        [self initializeViewWithCrumbAd:adData];
        
        [self addSubview:self.mainLabel];
        Underscore.array(self.imageGallery)
        .each(^(AsyncImageView *frame){
            [self addSubview:frame];
        });
        UITapGestureRecognizer *bannerAdTapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:tapDelegate action:tapAction];
        [self.bannerAdTapDetector addGestureRecognizer:bannerAdTapGestureRecognizer];
        [self addSubview:self.bannerAdTapDetector];
    }
    return self;
}

-(void)initializeViewWithCrumbAd:(NSDictionary *)adData{
    self.mainLabel.text = [adData valueForKey:@"retailer"];
    NSMutableArray *products = [NSMutableArray arrayWithArray:[adData valueForKey:@"products"]];
    Underscore.array(self.imageGallery)
    .each(^(AsyncImageView *frame){
        if ([products count] > 0) {
            frame.imageURL = [NSURL URLWithString:[[products lastObject] valueForKey:@"image_url"]];
            [products removeLastObject];
        }
    });
}

-(UILabel *)mainLabel{
    if (!_mainLabel){
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 14, 105, 21)];
        _mainLabel.adjustsFontSizeToFitWidth = YES;
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        _mainLabel.font = [UIFont fontWithName:@"Helvetica Bold Oblique" size:16];
        _mainLabel.textColor = [UIColor whiteColor];
        _mainLabel.text = @"Retailer";
    }
    return _mainLabel;
}

-(NSArray *)imageGallery{
    if (!_imageGallery){
        _imageGallery = @[[[AsyncImageView alloc] initWithFrame:CGRectMake(120, 2, 45, 45)],
                          [[AsyncImageView alloc] initWithFrame:CGRectMake(170, 2, 45, 45)],
                          [[AsyncImageView alloc] initWithFrame:CGRectMake(220, 2, 45, 45)],
                          [[AsyncImageView alloc] initWithFrame:CGRectMake(270, 2, 45, 45)]];
        Underscore.array(_imageGallery)
        .each(^(AsyncImageView *frame){
            [frame setContentMode:UIViewContentModeScaleAspectFit];
        });
    }
    return _imageGallery;
}

-(UIView *)bannerAdTapDetector{
    if (!_bannerAdTapDetector){
        _bannerAdTapDetector = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    }
    return _bannerAdTapDetector;
}

-(UIView *)bannerAdCover{
    if (!_bannerAdCover){
        _bannerAdCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _bannerAdCover.backgroundColor = [UIColor blackColor];
    }
    return _bannerAdCover;
}

-(void)hideAd{
    [self addSubview:self.bannerAdCover];
}

-(void)unhideAd{
    [self.bannerAdCover removeFromSuperview];
}

@end
