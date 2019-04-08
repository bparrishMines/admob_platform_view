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
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admob example'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (BuildContext context, int id) {
          if (id.isOdd) return Divider();

          if (id != 0 && id % 8 == 0) {
            return Container(
              constraints: BoxConstraints.expand(height: 100),
              child: Ad(),
            );
          }

          return Container(
            constraints: BoxConstraints.expand(height: 150),
            color: Colors.green,
          );
        },
      ),
    );
  }
}
