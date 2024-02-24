import 'package:flutter/material.dart';
import 'package:t_store/core/models/success_model.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/widgets/success_view.dart';
import 'package:t_store/features/auth/presentation/views/login_view.dart';

class EmailVerifiedSuccessfully extends StatelessWidget {
  const EmailVerifiedSuccessfully({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SuccessView(
      successModel: SuccessModel(
        image: TImages.staticSuccessIllustration,
        title: TTexts.yourAccountCreatedTitle,
        subTitle: TTexts.yourAccountCreatedSubTitle,
        onPressed: () {
          THelperFunctions.navigateReplacementToScreen(
              context, const LoginView());
        },
      ),
    );
  }
}
