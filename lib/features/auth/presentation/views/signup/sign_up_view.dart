import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:t_store/features/auth/presentation/widgets/divider_widget.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_in_methods_section.dart';
import 'package:t_store/features/auth/presentation/widgets/sign_up_form_section.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
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
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const SignUpFormSection(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const DividerWidget(text: TTexts.orSignUpWith),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const SignInMethodsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
