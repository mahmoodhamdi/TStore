import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:t_store/core/cubits/banner_carousel_slider_cubit_cubit/banner_carousel_slider_cubit.dart';
import 'package:t_store/core/cubits/navigation_menu_cubit/navigation_menu_cubit.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart';
import 'package:t_store/core/utils/theme/theme.dart';
import 'package:t_store/features/auth/data/bloc/bloc_observer.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/models/on_boarding_cubit.dart';
import 'package:t_store/features/auth/presentation/views/on_boarding/on_boarding_view.dart';
import 'package:t_store/features/personalization/data/repositories/user_repo_impl.dart';
import 'package:t_store/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:t_store/firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => NavigationMenuCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => BannerCarouselSliderCubit(),
        ),
        BlocProvider(create: (context) => UserCubit(getIt.get<UserRepoImpl>()))
      ],
      child: MaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: true,
        home: const OnBoardingView(),
      ),
    );
  }
}

