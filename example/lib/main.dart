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
  bool _loadAds = false;

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
            ),
            if (_loadAds) Container(width: 200, height: 300, child: Ad()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _loadAds = !_loadAds),
        child: Icon(Icons.close),
      ),
    );
  }
}
