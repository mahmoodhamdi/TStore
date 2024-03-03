import 'package:flutter/material.dart';
import 'package:t_store/core/models/app_bar_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/widgets/app_bar.dart';
import 'package:t_store/core/widgets/primary_header_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PrimaryHeaderContainer(
              child: Column(
            children: [
              CustomAppBar(
                appBarModel: AppBarModel(
                    title: Text(
                  TTexts.account,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                )),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
