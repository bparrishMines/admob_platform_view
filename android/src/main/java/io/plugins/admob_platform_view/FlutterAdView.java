package io.plugins.admob_platform_view;

import android.content.Context;
import android.view.View;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;

import io.flutter.plugin.platform.PlatformView;

public class FlutterAdView implements PlatformView {
  private final AdView adView;

  FlutterAdView(Context context, AdSize size) {
    adView = new AdView(context);
    adView.setAdSize(size);
    adView.setAdUnitId("ca-app-pub-3940256099942544/6300978111");

    AdRequest adRequest = new AdRequest.Builder().build();
    adView.loadAd(adRequest);
  }

  @Override
  public View getView() {
    return adView;
  }

  @Override
  public void dispose() {

  }
}
