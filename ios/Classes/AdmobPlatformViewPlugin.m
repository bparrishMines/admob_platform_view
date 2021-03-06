#import "AdmobPlatformViewPlugin.h"
#import "Firebase.h"

@implementation AdmobPlatformViewPlugin
- (instancetype)init {
  self = [super init];
  if (self && ![FIRApp appNamed:@"__FIRAPP_DEFAULT"]) {
    NSLog(@"Configuring the default Firebase app...");
    [FIRApp configure];
    NSLog(@"Configured the default Firebase app %@.", [FIRApp defaultApp].name);
  }
  return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [registrar registerViewFactory:[[FLTAdViewFactory alloc] init] withId:@"plugins.flutter.io/firebase_admob/adview"];
  [registrar registerViewFactory:[[FLTNativeAdViewFactory alloc] init] withId:@"plugins.flutter.io/firebase_admob/adview/native"];

  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins.flutter.io/firebase_admob"
            binaryMessenger:[registrar messenger]];

  AdmobPlatformViewPlugin* instance = [[AdmobPlatformViewPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"initialize"]) {
    [self callInitialize:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)callInitialize:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = (NSString *)call.arguments[@"appId"];
  if (appId == nil || [appId length] == 0) {
    result([FlutterError errorWithCode:@"no_app_id"
                               message:@"a non-empty AdMob appId was not provided"
                               details:nil]);
    return;
  }

  [GADMobileAds configureWithApplicationID:appId];
  result(nil);
}
@end
