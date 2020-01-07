#import "AdmobPlatformViewPlugin.h"
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

@interface FLTNativeAdView ()
@property(nonatomic, strong) GADUnifiedNativeAdView *adView;
@property UIViewController *adViewController;
@property GADAdLoader *adLoader;
@end

@implementation FLTNativeAdView
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super init];
  if (self) {
    _adViewController = [[UIViewController alloc] init];

    _adLoader = [[GADAdLoader alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/3986624511"
                       rootViewController:_adViewController
                                  adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                                  options:nil];
    _adLoader.delegate = self;
  }

  GADRequest *request = [GADRequest request];
  request.testDevices = @[ kGADSimulatorID ];
  [_adLoader loadRequest:request];
  return self;
}

- (UIView *)view {
  return _adViewController.view;
}

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
  NSLog(@"%@", error.description);
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
  nativeAd.delegate = self;

  // Create and place ad in view hierarchy.
  _adView =
      [[NSBundle mainBundle] loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil].firstObject;

  // Associate the native ad view with the native ad object. This is
  // required to make the ad clickable.
  _adView.nativeAd = nativeAd;

  // Set the mediaContent on the GADMediaView to populate it with available
  // video/image asset.
  //_adView.mediaView.mediaContent = nativeAd.mediaContent;

  // Populate the native ad view with the native ad assets.
  // The headline is guaranteed to be present in every native ad.
  ((UILabel *)_adView.headlineView).text = nativeAd.headline;

//   These assets are not guaranteed to be present. Check that they are before
//   showing or hiding them.
  ((UILabel *)_adView.bodyView).text = nativeAd.body;
  _adView.bodyView.hidden = nativeAd.body ? NO : YES;

  [((UIButton *)_adView.callToActionView)setTitle:nativeAd.callToAction
                                              forState:UIControlStateNormal];
  _adView.callToActionView.hidden = nativeAd.callToAction ? NO : YES;

    ((UIImageView *)_adView.iconView).image = nativeAd.icon.image;
  _adView.iconView.hidden = nativeAd.icon ? NO : YES;

  ((UILabel *)_adView.storeView).text = nativeAd.store;
  _adView.storeView.hidden = nativeAd.store ? NO : YES;

  ((UILabel *)_adView.priceView).text = nativeAd.price;
  _adView.priceView.hidden = nativeAd.price ? NO : YES;

  ((UILabel *)_adView.advertiserView).text = nativeAd.advertiser;
  _adView.advertiserView.hidden = nativeAd.advertiser ? NO : YES;

  // In order for the SDK to process touch events properly, user interaction
  // should be disabled.
  _adView.callToActionView.userInteractionEnabled = NO;

  [_adViewController.view addSubview:_adView];
}

- (void)nativeAdDidRecordImpression:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdDidRecordImpression");
}

- (void)nativeAdDidRecordClick:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdDidRecordClick");
}

- (void)nativeAdWillPresentScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdWillPresentScreen");
}

- (void)nativeAdWillDismissScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdWillDismissScreen");
}

- (void)nativeAdDidDismissScreen:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdDidDismissScreen");
}

- (void)nativeAdWillLeaveApplication:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"nativeAdWillLeaveApplication");
}

@end
