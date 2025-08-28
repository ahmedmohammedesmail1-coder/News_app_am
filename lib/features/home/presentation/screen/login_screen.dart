import 'package:flutter/material.dart';
import 'package:news_app_am/core/theme/text_style.dart';
import 'package:news_app_am/core/util/constans/spacing.dart';
import 'package:news_app_am/core/util/extensions/context_extention.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login Screen',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To The Login Screen!',
              style: TextStyleManager.bold16,
            ),
            verticalSpace(50),
            ElevatedButton(  
                onPressed: () {
                  context.pop;
                },
                child: Text(
                  'To Home Screen',
                  style: TextStyleManager.regular20,
                ),)
          ],
        ),
      ),
    ); 
  }
}
