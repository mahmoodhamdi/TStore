import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/features/auth/presentation/widgets/divider_widget.dart';
import 'package:t_store/features/auth/presentation/widgets/login_form_section.dart';
import 'package:t_store/features/auth/presentation/widgets/login_header_section.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_in_methods_section.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
          padding: TSizes.paddingWithAppBarHeight,
          child: Column(
            children: [
              LoginHeaderSection(),
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
        )),
      ),
    );
  }
}
