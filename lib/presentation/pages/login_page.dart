import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/common/widgets/custom_snackbar.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_event.dart';
import 'package:synapsis_survei/presentation/bloc/login_bloc/login_state.dart';
import 'package:synapsis_survei/presentation/pages/survei_page.dart';
import 'package:synapsis_survei/presentation/widgets/custom_elevated_button.dart';
import 'package:synapsis_survei/presentation/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _checkBoxValue = ValueNotifier<bool>(false);

  @override
  void initState() {
    context
        .read<LoginBloc>()
        .add(const OnGetEmailCache(key: LoginPage.routeName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Login to Synapsis',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              const Text(
                'Email',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _emailController,
                isPassword: false,
                hintText: 'Email',
              ),
              const SizedBox(height: 10),
              const Text(
                'Password',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _passwordController,
                isPassword: true,
                hintText: 'Password',
                isObscure: true,
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder<bool>(
                valueListenable: _checkBoxValue,
                builder: (context, value, child) => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  checkColor: Colors.black87,
                  activeColor: Colors.grey[200],

                  title: const Text("Remember me"),
                  value: value,
                  onChanged: (newValue) {
                    _checkBoxValue.value = !_checkBoxValue.value;
                    log('cek value checkbox${_checkBoxValue.value}');
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  log('cek state $state');
                  if (state is EmailCacheLoaded) {
                    log('cek email cache ${state.email}');
                    _emailController.text = state.email;
                  }
                  if (state is LoginFailure) {
                    CustomSnackbar.showMessage(state.message, context);
                  }
                  if (state is EmailCacheError) {
                    CustomSnackbar.showMessage(state.message, context);
                  }
                  if (state is LoginSuccess) {
                    if (_checkBoxValue.value) {
                      context.read<LoginBloc>().add(
                            OnEmailSaved(
                              key: LoginPage.routeName,
                              email: _emailController.text,
                            ),
                          );
                    } else {
                      context.read<LoginBloc>().add(
                            const OnEmailSaved(
                              key: LoginPage.routeName,
                              email: '',
                            ),
                          );
                    }
                    Navigator.pushNamedAndRemoveUntil(
                        context, SurveiPage.routeName, (route) => false);
                  }

                  if (state is LoginFingerprintSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SurveiPage.routeName, (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (state is LoginFailure) {
                  //   WidgetsBinding.instance.addPostFrameCallback(
                  //       (_) => _showMessage(state.message, context));
                  // }
                  if (state is LoginInitial ||
                      state is LoginFailure ||
                      state is EmailCacheLoaded ||
                      state is EmailSavedError) {
                    return Column(
                      children: [
                        CustomElevatedButton(
                          title: 'Log in',
                          isOutlined: false,
                          onPressed: () {
                            log('cek value ${_emailController.text}');
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              CustomSnackbar.showMessage(
                                  'Email or password cannot be empty', context);
                            } else {
                              context.read<LoginBloc>().add(
                                    OnLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text),
                                  );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'or',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          title: 'Fingerpint',
                          isOutlined: true,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
