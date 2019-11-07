#import "AdmobPlatformViewPlugin.h"
#import "GoogleMobileAds/GoogleMobileAds.h"
#import <UIKit/UIKit.h>

@interface FLTAdView ()
@property(nonatomic, strong) GADBannerView *adView;
@property UIViewController *adViewController;
@end

@implementation FLTAdView
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super init];
  if (self) {
    _adViewController = [[UIViewController alloc] init];
    
    _adView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    _adView.translatesAutoresizingMaskIntoConstraints = NO;
    [_adViewController.view addSubview:_adView];
    [_adViewController.view addConstraints:@[
      [NSLayoutConstraint constraintWithItem:_adView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_adViewController.bottomLayoutGuide
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:_adView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_adViewController.view
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:0]
      ]];
    
    _adView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    _adView.rootViewController = _adViewController;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [_adView loadRequest:request];
  }
  return self;
}

- (UIView *)view {
  return _adViewController.view;
}
@end
