import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:masihokeh/route/routes.dart';

void main() => runApp(MyApp());

class Application {
  static Router router;
}

class MyApp extends StatefulWidget {
  final Widget child;
  const MyApp({Key key, this.child}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "opensans", accentColor: Color(0xFF64C3AB)),
      onGenerateRoute: Application.router.generator,
    );
  }
}
