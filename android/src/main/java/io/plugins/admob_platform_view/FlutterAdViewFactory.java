package io.plugins.admob_platform_view;

import android.content.Context;

import com.google.android.gms.ads.AdSize;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FlutterAdViewFactory extends PlatformViewFactory {
  public FlutterAdViewFactory() {
    super(StandardMessageCodec.INSTANCE);
  }

  @Override
  public PlatformView create(Context context, int id, Object args) {
    return new FlutterAdView(context, AdSize.BANNER);
  }
}