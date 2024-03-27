import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';

class SignInMethodsSection extends StatelessWidget {
  const SignInMethodsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
          icon: const Image(
            height: TSizes.iconMd,
            width: TSizes.iconMd,
            image: AssetImage(TImages.google),
          ),
        ),
      ),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed: () {
            context.read<AuthCubit>().signInWithFacebook();
          },
          icon: const Image(
            height: TSizes.iconMd,
            width: TSizes.iconMd,
            image: AssetImage(TImages.facebook),
          ),
        ),
      ),
    ]);
  }
}
