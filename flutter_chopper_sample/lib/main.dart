import 'package:flutter/material.dart';
import 'package:flutter_chopper_sample/data/post_api_service.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

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
