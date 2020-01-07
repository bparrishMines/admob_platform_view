import 'package:flutter/material.dart';

import 'package:admob_platform_view/admob_platform_view.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showNativeAd = false;
  bool _showBannerAd = false;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admob example'),
      ),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        child: ListView(
          children: <Widget>[
            Container(
                width: data.size.width,
                height: data.size.height * 1.25,
                color: Colors.black,
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Show Banner Ad'),
                      onPressed: () => setState(
                        () => _showBannerAd = true,
                      ),
                    ),
                    RaisedButton(
                      child: Text('Show Native Ad'),
                      onPressed: () => setState(
                        () => _showNativeAd = true,
                      ),
                    )
                  ],
                )),
            if (_showBannerAd) Container(width: 200, height: 300, child: Ad()),
            if (_showNativeAd)
              Container(width: 500, height: 1000, child: NativeAd()),
          ],
        ),
      ),
    );
  }
}
