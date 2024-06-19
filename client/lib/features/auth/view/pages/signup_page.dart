import 'package:client/core/utils/snackbart.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/custom_formfield.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (previous, next) {
      next?.when(
        data: (data) {
          showSnackBar(
            context,
            'Account created successfully! Please  login.',
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SigninPage(),
            ),
          );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });
    final repo = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
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
                controller: nameController,
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
              AuthButton(
                text: 'Sign Up',
                onPressed: () {
                  print('pressed');
                  if (formKey.currentState!.validate()) {
                    ref.read(authViewModelProvider.notifier).signUpUser(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  } else {
                    showSnackBar(context, 'Please fill all the fields');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
