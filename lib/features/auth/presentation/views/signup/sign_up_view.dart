import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/signup/verify_email_view.dart';
import 'package:t_store/features/auth/presentation/widgets/divider_widget.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_in_methods_section.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_up_form_section.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSigningUpWithEmail) {
          return Scaffold(
              body: Center(child: Lottie.asset(TImages.docerAnimation)));
        } else if (state is AuthSignedUpWithEmail) {
          return VerifyEmailView(
            email: state.authRegisterModel.email,
          );
        } else if (state is AuthError) {
          // Show error message
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      DividerWidget(
                        text: TTexts.orSignUpWith.capitalize!,
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
