// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';

class SignUpFormBloc extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneNoController;
  late TextEditingController passwordController;

  SignUpFormBloc() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneNoController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }

  Future<void> signUpWithEmail(BuildContext context) async {
    try {
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
        await context.read<AuthCubit>().signUpWithEmail(
            authRegisterModel: AuthRegisterModel(
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                username: usernameController.text.trim(),
                email: emailController.text.trim(),
                phoneNo: phoneNoController.text.trim(),
                password: passwordController.text.trim()));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign up: $e");
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
