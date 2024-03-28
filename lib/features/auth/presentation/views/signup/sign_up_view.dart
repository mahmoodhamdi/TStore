import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/common/widgets/navigation_menu.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/signup/verify_email_view.dart';
import 'package:t_store/features/auth/presentation/widgets/divider_widget.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_in_methods_section.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_up_form_section.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          // Show error message
          THelperFunctions.showSnackBar(
            message: state.message,
            context: context,
          );
        } else if (state is AuthSignedUpWithEmail) {
          context.read<AuthCubit>().sendVerificationEmail();
          THelperFunctions.navigateReplacementToScreen(
              context,
              VerifyEmailView(
                email: state.authRegisterModel.email,
              ));
        }
      },
      builder: (context, state) {
        if (state is AuthSigningUpWithEmail ||
            state is AuthSigningInWithFacebook ||
            state is AuthSigningUpWithGoogle) {
          return Scaffold(
              body: Center(child: Lottie.asset(TImages.docerAnimation)));
        } else if (state is AuthSignedInWithFacebook ||
            state is AuthSignedInWithGoogle) {
          return const NavigationMenu();
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TTexts.signUpTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const SignUpFormSection(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const DividerWidget(
                    text: TTexts.orSignUpWith,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const SignInMethodsSection(),
                ],
              ),
            )),
          );
        }
      },
    );
  }
}
