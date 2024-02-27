import 'package:flutter/material.dart';
import 'package:t_store/features/shop/presentation/widgets/home_header_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeHeaderSection(),
            
          ],
        ),
      ),
    );
  }
}
