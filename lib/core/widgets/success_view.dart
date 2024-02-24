import 'package:flutter/material.dart';
import 'package:t_store/core/models/success_model.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/device/device_utility.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({
    super.key,
    required this.successModel,
  });
  final SuccessModel successModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSizes.paddingWithAppBarHeight,
          child: Column(
            children: [
              Image(
                  width: TDeviceUtils.getScreenWidth(context) * .75,
                  image: AssetImage(successModel.image)),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                successModel.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                successModel.subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: successModel.onPressed,
                    child: Text(successModel.buttonText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
