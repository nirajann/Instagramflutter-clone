import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/mobileScreenLayout.dart';
import 'package:instagram_flutter/responsive/responsivelayoutscreen.dart';
import 'package:instagram_flutter/responsive/webScreenLayout.dart';

import 'utlis/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'instafly',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
