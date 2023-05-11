import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/screens/signupScreen.dart';
import 'package:instagram_flutter/utlis/colors.dart';
import 'package:instagram_flutter/utlis/utlis.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/responsivelayoutscreen.dart';
import '../responsive/webScreenLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void LoginUser() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      isloading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(
          flex: 2,
          child: Container(),
        ),
        SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 64,
        ),
        const SizedBox(
          height: 64,
        ),
        TextFieldInput(
          hintText: "Enter Your Email",
          textInputType: TextInputType.emailAddress,
          textEditingController: _emailController,
        ),
        const SizedBox(
          height: 30,
        ),
        TextFieldInput(
          hintText: "Enter Your password",
          textInputType: TextInputType.visiblePassword,
          textEditingController: _passwordController,
          isPass: true,
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            LoginUser();
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
                color: isloading ? Colors.black : Colors.purple,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                )),
            child: isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  )
                : const Text('Login'),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text("Dont Have An Account? "),
            ),
            GestureDetector(
              onTap: () {
                navigateToSignup();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )
      ]),
    )));
  }
}
