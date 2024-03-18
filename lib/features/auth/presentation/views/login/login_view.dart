import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/common/widgets/navigation_menu.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/widgets/divider_widget.dart';
import 'package:t_store/features/auth/presentation/widgets/login_form_section.dart';
import 'package:t_store/features/auth/presentation/widgets/login_header_section.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_in_methods_section.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInWithEmail) {
          THelperFunctions.navigateReplacementToScreen(context, const NavigationMenu());
        } else if (state is AuthError) {
          // Display snackbar with error message
          THelperFunctions.showSnackBar(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoggingInWithEmail) {
          return Scaffold(
            body: Center(child: Lottie.asset(TImages.docerAnimation)),
          );
        } else if (state is AuthLoggedInWithEmail) {
          return const NavigationMenu();
        } else {
          return const Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: TSizes.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    LoginHeaderSection(),
                    // Pass the GlobalKey to LoginFormSection
                    LoginFormSection(),
                    DividerWidget(
                      text: TTexts.orSignInWith,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SignInMethodsSection(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
