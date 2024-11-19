import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/widgets/navigation_menu.dart';
import 'package:t_store/core/cubits/navigation_menu_cubit/navigation_menu_cubit.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart';
import 'package:t_store/features/auth/data/models/login_req_body.dart';
import 'package:t_store/features/auth/domain/usecases/login_usecase.dart';
import 'package:t_store/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:t_store/features/auth/presentation/logic/login/login_state.dart';
import 'package:t_store/features/auth/presentation/views/password_configuration/forget_password_view.dart';
import 'package:t_store/features/auth/presentation/views/signup/sign_up_view.dart';
import 'package:t_store/features/shop/presentation/controller/shop_cubit.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final loginReqBody = LoginReqBody(
        phoneEmail: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      context.read<LoginCubit>().login(LoginParms(loginReqBody: loginReqBody));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.message,
            type: SnackBarType.success,
          );

          THelperFunctions.navigateReplacementToScreen(
            context,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<NavigationMenuCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<ShopCubit>()
                    ..getSortedProducts(sortBy: 'rating', sortType: "desc"),
                ),
              ],
              child: const NavigationMenu(),
            ),
          );
        } else if (state.status == LoginStatus.failure) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    labelText: TTexts.password,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? true;
                            });
                          },
                        ),
                        const Text(TTexts.rememberMe),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        THelperFunctions.navigateToScreen(
                          context,
                          const ForgetPasswordView(),
                        );
                      },
                      child: const Text(TTexts.forgetPassword),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.status == LoginStatus.loading
                        ? null
                        : () {
                            THelperFunctions.hideKeyboard();
                            _handleLogin();
                          },
                    child: state.status == LoginStatus.loading
                        ? const Text(TTexts.loading)
                        : const Text(TTexts.signIn),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      THelperFunctions.navigateToScreen(
                        context,
                        const SignUpView(),
                      );
                    },
                    child: const Text(TTexts.createAccount),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
