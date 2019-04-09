#import <Flutter/Flutter.h>

@interface AdmobPlatformViewPlugin : NSObject<FlutterPlugin>
@end

@interface FLTAdViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface FLTAdView : NSObject<FlutterPlatformView>
- (instancetype)initWithFrame:(CGRect)frame;
- (UIView *)view;
@end
