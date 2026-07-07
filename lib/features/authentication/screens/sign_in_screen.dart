import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/features/authentication/bloc/auth_bloc.dart';
import 'package:hedagent/features/authentication/bloc/auth_event.dart';
import 'package:hedagent/features/authentication/bloc/auth_state.dart';
import 'package:hedagent/features/authentication/data/models/login_request.dart';
import 'package:hedagent/features/authentication/utils/auth_navigation.dart';
import 'package:hedagent/route/app_router_names.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthBloc(), child: const _SignInView());
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisible = false;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$',
  );

  void _onSignInPressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    context.read<AuthBloc>().add(LoginRequested(request));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: redColor),
          );
        } else if (state is LoginSuccess) {
          navigateAfterAuth(context, state.user);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20 / 844 * size.height),
                Center(
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SvgPicture.asset(
                      colorFilter: ColorFilter.mode(
                        whiteColor,
                        BlendMode.srcIn,
                      ),
                      ImagePath.smallIconPath,
                      height: 12,
                      width: 12,
                    ),
                  ),
                ),
                Text(Texts.appNameText, style: AppTextStyle.firStyle),
                Text(
                  textAlign: TextAlign.center,
                  Texts.welcomeText,
                  style: AppTextStyle.sixStyle,
                ),
                Gap(24 / 844 * size.height),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 48,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Texts.emailLabelText, style: AppTextStyle.sevStyle),
                        Gap(8 / 844 * size.height),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: greyColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: greyColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!_emailRegExp.hasMatch(value.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        Gap(24 / 844 * size.height),
                        Text(
                          Texts.passwordLabelText,
                          style: AppTextStyle.sevStyle,
                        ),
                        Gap(8 / 844 * size.height),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            hintText: '***********',
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: greyColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_sharp
                                    : Icons.visibility_off_outlined,
                                color: greyColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: greyColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        Gap(24 / 844 * size.height),
                        elevBtn(
                          size,
                          isLoading ? null : _onSignInPressed,
                          Texts.signInText,
                          null,
                          null,
                          isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: whiteColor,
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to EduAgent? ', style: AppTextStyle.ninStyle),
                    TextButton(
                      onPressed: () =>
                          context.goNamed(RouteNames.signUpScreenString),
                      child: Text(
                        'Create an account',
                        style: AppTextStyle.tenStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
