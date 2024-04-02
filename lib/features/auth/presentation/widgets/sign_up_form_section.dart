// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/validators/validation.dart';
import 'package:t_store/features/auth/data/bloc/sign_up_form_bloc.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';

import 'terms_and_privacy_agreement.dart';

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  late SignUpFormBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SignUpFormBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _bloc.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      TValidator.validateEmpty(value, fieldName: "First Name"),
                  controller: _bloc.firstNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.firstName),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) => TValidator.validateEmpty(
                    value,
                    fieldName: "Last Name",
                  ),
                  controller: _bloc.lastNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.lastName),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validateEmpty(
              value,
              fieldName: "Username",
            ),
            controller: _bloc.usernameController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_edit),
                labelText: TTexts.username),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validateEmail(
              value,
            ),
            controller: _bloc.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct), labelText: TTexts.email),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validatePhoneNumber(value),
            controller: _bloc.phoneNoController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validatePassword(value),
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
                        context.read<AuthCubit>().togglePasswordVisibility();
                      });
                    }),
                labelText: TTexts.password),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          const TermsAndPrivacyAgreement(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  _bloc.signUpWithEmail(context);
                },
                child: const Text(TTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
