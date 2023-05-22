import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/addPostScreen.dart';
import 'package:instagram_flutter/screens/feedScreen.dart';
import 'package:instagram_flutter/screens/profileScreen.dart';
import 'package:instagram_flutter/screens/searchScreen.dart';

const webScreenSize = 600;

List<Widget> homescreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('data3'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
