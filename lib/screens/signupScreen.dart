import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utlis/colors.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
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
        Stack(
          children: [
            const CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.s9JFNLzEbjoZhjijeA5X-AHaHa?pid=ImgDet&rs=1'),
            ),
            Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.add_a_photo)))
          ],
        ),
        const SizedBox(
          height: 64,
        ),
        TextFieldInput(
          hintText: "Enter Your Username",
          textInputType: TextInputType.text,
          textEditingController: _usernameController,
        ),
        const SizedBox(
          height: 30,
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
        TextFieldInput(
          hintText: "Enter Your Bio",
          textInputType: TextInputType.text,
          textEditingController: _bioController,
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const ShapeDecoration(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              )),
          child: const Text('SignUp'),
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
              child: const Text("Already Have Account? "),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  "Login",
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
