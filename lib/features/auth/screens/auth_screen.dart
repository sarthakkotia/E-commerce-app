import 'package:ecommerce_app/common/widgets/custom_button.dart';
import 'package:ecommerce_app/common/widgets/custom_textfield.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum Auth { signin, signup }

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              RadioListTile(
                tileColor: (_auth == Auth.signup)
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _nameController,
                          hintText: "Name",
                        ),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(onTap: () {}, text: "Sign Up")
                      ],
                    ),
                  ),
                ),
              RadioListTile(
                tileColor: (_auth == Auth.signin)
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
                title: const Text(
                  "Sign-In",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(onTap: () {}, text: "Sign In")
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
