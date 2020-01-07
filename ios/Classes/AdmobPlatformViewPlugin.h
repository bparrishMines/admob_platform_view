#import <Flutter/Flutter.h>
#import "GoogleMobileAds/GoogleMobileAds.h"

@interface AdmobPlatformViewPlugin : NSObject<FlutterPlugin>
@end

@interface FLTAdViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface FLTAdView : NSObject<FlutterPlatformView>
- (instancetype)initWithFrame:(CGRect)frame;
- (UIView *)view;
@end

@interface FLTNativeAdViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface FLTNativeAdView : NSObject<FlutterPlatformView, GADUnifiedNativeAdLoaderDelegate, GADUnifiedNativeAdDelegate>
- (instancetype)initWithFrame:(CGRect)frame;
- (UIView *)view;
@end
