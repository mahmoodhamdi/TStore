// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/password_configuration/reset_password_view.dart';

class ResetPasswordFormBloc extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  ResetPasswordFormBloc() {
    emailController = TextEditingController();
  }

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }

  Future<void> resetPassword(BuildContext context) async {
    bool connected = await THelperFunctions.isConnected();
    if (!connected) {
      THelperFunctions.showAlert(
        type: AlertType.error,
        title: "Connection Error",
        message: "Please check your internet connection",
        context: context,
      );
    }

    if (formKey.currentState!.validate()) {
      await context
          .read<AuthCubit>()
          .sendResetPasswordEmail(email: emailController.text.trim());

      THelperFunctions.navigateReplacementToScreen(
          context, const ResetPasswordView());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
