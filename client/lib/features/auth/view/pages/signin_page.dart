import 'package:client/core/utils/snackbart.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/custom_formfield.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const SigninPage(),
          //   ),
          // );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
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
                  text: 'Sign In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(authViewModelProvider.notifier).signInUser(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    } else {
                      showSnackBar(context, 'Please fill all fields');
                    }
                  }),
            ],
          ),
        ));
  }
}
