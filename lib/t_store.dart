import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/theme/theme.dart';
import 'package:t_store/features/auth/presentation/cubit/on_boarding_cubit.dart';
import 'package:t_store/features/auth/presentation/views/on_boarding/on_boarding_view.dart';

class TStore extends StatelessWidget {
  const TStore({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: const OnBoardingView(),
      ),
    );
  }
}
