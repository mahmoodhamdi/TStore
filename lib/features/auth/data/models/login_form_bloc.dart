// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';

class LoginFormBloc extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginFormBloc() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }

  Future<void> loginWithEmail(BuildContext context) async {
    bool connected = await THelperFunctions.isConnected();
    if (!connected) {
      THelperFunctions.showAlert(
        type: AlertType.error,
        title: "Connection Error",
        message: "Please check your internet connection",
        context: context,
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      await context.read<AuthCubit>().loginWithEmail(
          authLoginWithEmailModel: AuthLoginWithEmailModel(
              email: emailController.text.trim(),
              password: passwordController.text.trim()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
