//
//  CrumbInterstitialAdViewController.m
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import "CrumbInterstitialAdViewController.h"

@interface CrumbInterstitialAdViewController ()

@property (strong, nonatomic) AsyncImageView *productImage;
@property (strong, nonatomic) UILabel *retailerName;
@property (strong, nonatomic) UILabel *productName;
@property (strong, nonatomic) UILabel *originalPrice;
@property (strong, nonatomic) UILabel *discountedPrice;
@property (strong, nonatomic) BButton *adCancelButton;


@end

@implementation CrumbInterstitialAdViewController

- (instancetype)initWithRetailerName:(NSString *)retailerName
                             product:(NSDictionary *)productData
                  cancelButtonTarget:(id)cancelButtonPressedTarget
                        buttonAction:(SEL)cancelButtonPressedAction{
    self = [super initWithNibName:nil bundle:nil];
    if (self){
        [self initializeViewWithRetailerName:retailerName
                                  andProductData:productData];
        [self.adCancelButton addTarget:cancelButtonPressedTarget
                                action:cancelButtonPressedAction
                      forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)initializeViewWithRetailerName:(NSString *)retailerName
                           andProductData:(NSDictionary *)productData{
    self.retailerName.text = retailerName;
    self.productName.text = [productData valueForKey:@"name"];
    self.discountedPrice.text = [NSString stringWithFormat:@"$%.2f", [[productData valueForKey:@"discounted_price"] floatValue]];
    self.productImage.imageURL = [NSURL URLWithString:[productData valueForKey:@"image_url"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%.2f", [[productData valueForKey:@"original_price"] floatValue]]];
    [attributedString addAttributes:@{NSStrikethroughStyleAttributeName : @2,
                                      NSForegroundColorAttributeName : [UIColor redColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica Bold Oblique" size:20]}
                              range:NSMakeRange(0, [attributedString length])];
    self.originalPrice.attributedText = attributedString;
}

- (void)loadView{
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    rootView.backgroundColor = [UIColor whiteColor];
    [rootView addSubview:self.productImage];
    [rootView addSubview:self.retailerName];
    [rootView addSubview:self.productName];
    [rootView addSubview:self.originalPrice];
    [rootView addSubview:self.discountedPrice];
    [rootView addSubview:self.adCancelButton];
    self.view = rootView;
}

- (BButton *)adCancelButton{
    if (!_adCancelButton){
        _adCancelButton = [[BButton alloc] initWithFrame:CGRectMake(5, 25, 65, 25)
                                                    type:BButtonTypeDanger
                                                   style:BButtonStyleBootstrapV3];
        [_adCancelButton setTitle:@"Close Ad" forState:UIControlStateNormal];
        _adCancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold"
                                                          size:12];
        _adCancelButton.titleLabel.textColor = [UIColor whiteColor];
        
    }
    return _adCancelButton;
}

-(UILabel *)retailerName{
    if (!_retailerName){
        _retailerName = [[UILabel alloc] initWithFrame:CGRectMake(20, 354, 280, 30)];
        _retailerName.adjustsFontSizeToFitWidth = YES;
        _retailerName.textAlignment = NSTextAlignmentCenter;
        _retailerName.font = [UIFont fontWithName:@"Helvetica Bold" size:25];
        _retailerName.text = @"Retailer";
    }
    return _retailerName;
}

-(UILabel *)productName{
    if (!_productName){
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(20, 392, 280, 50)];
        _productName.numberOfLines = 2;
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.font = [UIFont fontWithName:@"Helvetica" size:16];
        _productName.text = @"Description";
    }
    return _productName;
}

-(UILabel *)discountedPrice{
    if (!_discountedPrice){
        _discountedPrice = [[UILabel alloc] initWithFrame:CGRectMake(160, 472, 140, 21)];
        _discountedPrice.textAlignment = NSTextAlignmentCenter;
        _discountedPrice.font = [UIFont fontWithName:@"Helvetica Bold Oblique" size:20];
        _discountedPrice.text = @"New Price";
        _discountedPrice.textColor = [UIColor blueColor];
    }
    return _discountedPrice;
}

-(UILabel *)originalPrice{
    if (!_originalPrice){
        _originalPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 472, 140, 21)];
        _originalPrice.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Old Price"];
        [attributedString addAttributes:@{NSStrikethroughStyleAttributeName : @2,
                                          NSForegroundColorAttributeName : [UIColor redColor],
                                          NSFontAttributeName : [UIFont fontWithName:@"Helvetica Bold Oblique" size:20]}
                                  range:NSMakeRange(0, [attributedString length])];
        _originalPrice.attributedText = attributedString;
    }
    return _originalPrice;
}

-(AsyncImageView *)productImage{
    if (!_productImage){
        _productImage = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
        [_productImage setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _productImage;
}

@end
