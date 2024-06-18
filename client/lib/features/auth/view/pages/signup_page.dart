import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/custom_formfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomFormField(
                controller: usernameController,
                hintText: 'Username',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                obscureText: true,
                controller: passwordController,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 10,
              ),
              const AuthButton(text: 'Sign Up'),
            ],
          ),
        ));
  }
}
