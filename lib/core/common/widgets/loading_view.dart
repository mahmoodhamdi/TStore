import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset(TImages.docerAnimation)),
    );
  }
}
