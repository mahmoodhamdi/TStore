import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class TLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const TLoadingIndicator({super.key, this.size = 40.0, this.color});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color indicatorColor =
        color ?? (isDark ? TColors.accent : TColors.primary);

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        backgroundColor: isDark ? TColors.darkGrey : TColors.lightGrey,
      ),
    );
  }
}
