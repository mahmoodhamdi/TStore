import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/validators/validation.dart';
import 'package:t_store/features/auth/data/bloc/login_form_bloc.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/password_configuration/forget_password_view.dart';
import 'package:t_store/features/auth/presentation/views/signup/sign_up_view.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({
    super.key,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  late LoginFormBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LoginFormBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Form(
          key: _bloc.formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) => TValidator.validateEmail(value),
                controller: _bloc.emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                validator: (value) =>
                    TValidator.validateEmpty(value, fieldName: "Password"),
                controller: _bloc.passwordController,
                obscureText: context.read<AuthCubit>().obscureText,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        icon: context.read<AuthCubit>().obscureText
                            ? const Icon(Iconsax.eye_slash)
                            : const Icon(Iconsax.eye),
                        onPressed: () {
                          setState(() {
                            context
                                .read<AuthCubit>()
                                .togglePasswordVisibility();
                          });
                        }),
                    labelText: TTexts.password),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                      const Text(TTexts.rememberMe),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      THelperFunctions.navigateToScreen(
                          context, const ForgetPasswordView());
                    },
                    child: const Text(TTexts.forgetPassword),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _bloc.loginWithEmail(context);
                  },
                  child: const Text(TTexts.signIn),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    THelperFunctions.navigateToScreen(
                        context, const SignUpView());
                  },
                  child: const Text(TTexts.createAccount),
                ),
              ),
            ],
          )),
    );
  }
}
