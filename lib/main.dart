import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_flutter/provider/user_provider.dart';
import 'package:instagram_flutter/responsive/mobileScreenLayout.dart';
import 'package:instagram_flutter/screens/loginScreen.dart';
import 'package:provider/provider.dart';

import 'responsive/responsivelayoutscreen.dart';
import 'responsive/webScreenLayout.dart';
import 'utlis/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBGtRX2usqCoViyJJy3olOs7avIKw5o9is',
            appId: '1:301594495135:web:cf72ffcc63b08259563aaa',
            messagingSenderId: '301594495135',
            projectId: 'instagram-clone-c7536',
            storageBucket: 'instagram-clone-c7536.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'instafly',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // )
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.amber,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
