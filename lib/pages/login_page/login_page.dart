import 'package:flutter/material.dart';
import 'package:focusflow/pages/base_page.dart';
import 'package:focusflow/pages/login_page/widgets/login_form.dart';

class LoginPage extends BasePage {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final targetWidth = screenSize.width * 0.3;
    final targetHeight = screenSize.height * 0.6;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -targetHeight * 0.6,
            left: -targetHeight * 0.4,
            child: Container(
              width: targetHeight * 1.8,
              height: targetHeight * 1.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 28, 184, 220),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: targetWidth * 1.2,
                    height: targetHeight * 1.2,
                    child: Card(
                      child: LoginForm(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/men_pointing.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
