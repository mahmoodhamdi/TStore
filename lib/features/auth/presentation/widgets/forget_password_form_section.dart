import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/validators/validation.dart';
import 'package:t_store/features/auth/data/models/forget_password_form_bloc.dart';

class ForgetPasswordFormSection extends StatefulWidget {
  const ForgetPasswordFormSection({super.key});

  @override
  State<ForgetPasswordFormSection> createState() =>
      _ForgetPasswordFormSectionState();
}

class _ForgetPasswordFormSectionState extends State<ForgetPasswordFormSection> {
  late ResetPasswordFormBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ResetPasswordFormBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

//ForgetPasswordFormSection >> forget_password_form_section.dart
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _bloc.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _bloc.emailController,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  _bloc.resetPassword(context);
                },
                child: const Text(TTexts.submit)),
          ),
        ],
      ),
    );
  }
}
