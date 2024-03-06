import 'package:flutter/material.dart';
import 'package:turtle/app/utils/app_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('login screen', style: AppStyle.bold14));
  }
}
