import 'package:flutter/material.dart';
import 'package:t_store/core/widgets/primary_header_container.dart';
import 'package:t_store/features/shop/presentation/widgets/home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeAppBar(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
