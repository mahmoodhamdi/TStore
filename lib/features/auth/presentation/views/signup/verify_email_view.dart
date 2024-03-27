import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/device/device_utility.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/login/login_view.dart';
import 'package:t_store/features/auth/presentation/widgets/email_verified_successfully.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthVerifiedEmail) {
        THelperFunctions.navigateReplacementToScreen(
            context, const EmailVerifiedSuccessfully());
      } else if (state is AuthError) {
        THelperFunctions.showSnackBar(
          message: state.message,
          context: context,
        );
      } else if (state is AuthVerifyingEmailSent) {
        THelperFunctions.showSnackBar(
            type: SnackBarType.success,
            message: "verifying email sent to $email",
            context: context);
        context.read<AuthCubit>().isVerified();
      } else if (state is AuthUnverifiedEmail) {
        THelperFunctions.showSnackBar(
          type: SnackBarType.error,
          message: "please verify your email",
          context: context,
        );
      }
    }, builder: (context, state) {
      context.read<AuthCubit>().isVerified();
      if (state is AuthVerifiedEmail) {
        return const EmailVerifiedSuccessfully();
      }
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                THelperFunctions.navigateReplacementToScreen(
                    context, const LoginView());
              },
              icon: const Icon(CupertinoIcons.clear),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Image(
                    width: TDeviceUtils.getScreenWidth(context) * .8,
                    image:
                        const AssetImage(TImages.deliveredEmailIllustration)),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  TTexts.confirmEmailTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  email,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().sendVerificationEmail();
                      },
                      child: const Text(TTexts.resendEmail)),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
