package io.plugins.admob_platform_view;

import com.google.android.gms.ads.MobileAds;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** AdmobPlatformViewPlugin */
public class AdmobPlatformViewPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    registrar
        .platformViewRegistry()
        .registerViewFactory(
            "plugins.flutter.io/firebase_admob/adview", new FlutterAdViewFactory());

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "plugins.flutter.io/firebase_admob");
    channel.setMethodCallHandler(new AdmobPlatformViewPlugin(registrar));
  }

  final Registrar registrar;

  private AdmobPlatformViewPlugin(Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("initialize")) {
      callInitialize(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void callInitialize(MethodCall call, Result result) {
    String appId = call.argument("appId");
    if (appId == null || appId.isEmpty()) {
      result.error("no_app_id", "a null or empty AdMob appId was provided", null);
      return;
    }

    MobileAds.initialize(registrar.context(), appId);
    result.success(null);
  }
}
