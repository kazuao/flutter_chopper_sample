import 'package:flutter/material.dart';
import 'package:flutter_chopper_sample/data/post_api_service.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostApiService.create(),
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'MaterialApp',
        home: HomePage(),
      ),
    );
  }
}
