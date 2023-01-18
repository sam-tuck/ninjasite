import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:jsninja/admin_viewpage.dart';
import 'package:login/login.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //Temporary AppBar for workaround to admin page
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_box),
            padding: EdgeInsets.only(right: 40.0),
            tooltip: 'Admin Login',
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminViewWidget()),
              );
            },
          )
        ],
      ),
        body: LoginScreen(
      screenTitle: "Log in",
      loginOptions: {
        "loginGitHub": true,
        "loginGoogle": true,
        "loginEmail": true,
        "loginSSO": true,
        "loginAnonymous": true,
        "signupOption": true,
      },
      mainTitle: "AML Cloud",
    ));
  }
}
