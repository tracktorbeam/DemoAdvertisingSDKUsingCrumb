//
//  CrumbAdFetchDelegate.h
//  DemoAdvertisingSDKUsingCrumb
//
//  Created by Arpan Ghosh on 2/9/14.
//  Copyright (c) 2014 Tracktor Beam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CrumbAdFetchDelegate <NSObject>
@required
-(void)fetchedAdFromCrumb:(NSDictionary *)ad;
-(void)noAdInventoryAvailableOnCrumb;
-(void)errorFetchingAdFromCrumb:(NSError *)error;
@end
