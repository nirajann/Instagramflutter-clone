import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/responsivelayoutscreen.dart';
import 'package:instagram_flutter/utlis/colors.dart';
import 'package:instagram_flutter/utlis/utlis.dart';
import 'package:instagram_flutter/widgets/text_field.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/webScreenLayout.dart';

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
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupuser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signUpUser(
        bio: _bioController.text,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        file: _image!);

    setState(() {
      _isloading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    }
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
          height: 50,
        ),
        Stack(
          children: [
            _image != null
                ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png'),
                  ),
            Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(Icons.add_a_photo)))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFieldInput(
          hintText: "Enter Your Username",
          textInputType: TextInputType.text,
          textEditingController: _usernameController,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldInput(
          hintText: "Enter Your Email",
          textInputType: TextInputType.emailAddress,
          textEditingController: _emailController,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldInput(
          hintText: "Enter Your password",
          textInputType: TextInputType.visiblePassword,
          textEditingController: _passwordController,
          isPass: true,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldInput(
          hintText: "Enter Your Bio",
          textInputType: TextInputType.text,
          textEditingController: _bioController,
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: signupuser,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const ShapeDecoration(
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                )),
            child: _isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  )
                : const Text('SignUp'),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ]),
    )));
  }
}
