// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Support for Google AdMob mobile ads.
class FirebaseAdMob {
  @visibleForTesting
  FirebaseAdMob.private(MethodChannel channel) : _channel = channel;

  // A placeholder AdMob App ID for testing. AdMob App IDs and ad unit IDs are
  // specific to a single operating system, so apps building for both Android and
  // iOS will need a set for each platform.
  static final String testAppId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-3940256099942544~1458002511';

  static final FirebaseAdMob _instance = FirebaseAdMob.private(
    const MethodChannel('plugins.flutter.io/firebase_admob'),
  );

  /// The single shared instance of this plugin.
  static FirebaseAdMob get instance => _instance;

  final MethodChannel _channel;

  /// Initialize this plugin for the AdMob app specified by `appId`.
  Future<void> initialize({
    @required String appId,
    String trackingId,
    bool analyticsEnabled = false,
  }) {
    assert(appId != null && appId.isNotEmpty);
    assert(analyticsEnabled != null);

    return _channel.invokeMethod<void>("initialize", <String, dynamic>{
      'appId': appId,
      'trackingId': trackingId,
      'analyticsEnabled': analyticsEnabled,
    });
  }
}

class Ad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(viewType: 'plugins.flutter.io/firebase_admob/adview')
        : UiKitView(viewType: 'plugins.flutter.io/firebase_admob/adview');
  }
}

class NativeAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: 'plugins.flutter.io/firebase_admob/adview/native')
        : UiKitView(
            viewType: 'plugins.flutter.io/firebase_admob/adview/native');
  }
}
