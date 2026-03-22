import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/core/router/app_router.dart';
import 'package:portfolio/features/login/appfield/app_text_field.dart';
import 'package:portfolio/features/login/model/email_login.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Login extends HookConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = LoginEmail.form();
    return Scaffold(
      body: Center(
          child: ReactiveForm(
        formGroup: form,
        child: Container(
          width: 400,
          height: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.grey[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Gap(24),
                AppTextField<String>(
                  formControlName: 'email',
                  label: 'Email',
                  hint: 'example@email.com',
                  fieldType: AppFieldType.email,
                  prefixIcon: Icons.email_outlined,
                ),
                Gap(12),
                AppTextField<String>(
                  formControlName: 'password',
                  label: 'Password',
                  hint: "Enter your password",
                  fieldType: AppFieldType.password,
                  prefixIcon: Icons.lock_outlined,
                ),
                Gap(24),
                ElevatedButton(
                  onPressed: () {
                    if (form.valid) {
                      final email = form.control('email').value;
                      final password = form.control('password').value;

                      if (email == 'test@g.co' && password == '12341234') {
                        ref.read(appRouterProvider).goNamed('home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid credentials')),
                        );
                      }
                    } else {
                      form.markAllAsTouched();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fix the errors in the form')),
                      );
                    }
                    debugPrint(
                        'Form valid: ${form.valid}, email: ${form.control('email').value}, password: ${form.control('password').value}');
                  },
                  child: const Text('Login', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
