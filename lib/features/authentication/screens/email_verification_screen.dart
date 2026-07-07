import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/features/authentication/bloc/auth_bloc.dart';
import 'package:hedagent/features/authentication/bloc/auth_event.dart';
import 'package:hedagent/features/authentication/bloc/auth_state.dart';
import 'package:hedagent/features/authentication/utils/auth_navigation.dart';
import 'package:hedagent/route/app_router_names.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: const _EmailVerificationView(),
    );
  }
}

class _EmailVerificationView extends StatelessWidget {
  const _EmailVerificationView();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: redColor),
          );
        } else if (state is VerificationPending) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Verification is not completed yet. Please check your '
                'email and click the verification link, then try again.',
              ),
              backgroundColor: redColor,
            ),
          );
        } else if (state is VerificationEmailResent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent.')),
          );
        } else if (state is VerificationConfirmed) {
          navigateAfterAuth(context, state.user);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(Texts.appNameText, style: AppTextStyle.firStyle),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(32 / 844 * size.height),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(32.0 / 844 * size.height),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.mark_email_unread_outlined,
                          color: primaryColor,
                          size: 48,
                        ),
                        Gap(16 / 844 * size.height),
                        Text(
                          'Verify your email',
                          style: AppTextStyle.twentSixStyle,
                        ),
                        Gap(8 / 844 * size.height),
                        Text(
                          "We've sent a verification link to your email "
                          'address. Click the link, then tap the button '
                          'below to confirm.',
                          style: AppTextStyle.nintStyle,
                        ),
                        Gap(24 / 844 * size.height),
                        elevBtn(
                          size,
                          isLoading
                              ? null
                              : () => context.read<AuthBloc>().add(
                                  const CheckEmailVerification(),
                                ),
                          "I've verified my email",
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
                        Gap(12 / 844 * size.height),
                        Center(
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () => context.read<AuthBloc>().add(
                                    const ResendVerificationEmail(),
                                  ),
                            child: Text(
                              'Resend email',
                              style: AppTextStyle.tenStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(32 / 844 * size.height),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        context.goNamed(RouteNames.signInScreenString),
                    child: Text('Back to Sign In', style: AppTextStyle.tenStyle),
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
