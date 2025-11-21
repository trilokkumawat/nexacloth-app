import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/btn.dart';
import 'package:nexacloth/components/card/customgooglecard.dart';
import 'package:nexacloth/components/customtextfield.dart';
import 'package:nexacloth/components/fontsize.dart';
import 'package:nexacloth/components/gaps.dart';
import 'package:nexacloth/components/safe_set_state_mixin.dart';
import 'package:nexacloth/core/route/routename.dart';
import 'package:nexacloth/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SafeSetStateMixin {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    safeSetState(() {});
  }

  void _handleEmailAuth() {
    _controller.handleEmailAuth(
      onSuccess: () {
        if (_controller.isLoginMode) {
          if (mounted) {
            context.go(RouteNames.home);
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Account created! Please check your email for verification.',
                ),
                backgroundColor: CustomAppColor.success,
              ),
            );
          }
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              backgroundColor: CustomAppColor.error,
            ),
          );
        }
      },
    );
  }

  void _handleGoogleSignIn() {
    _controller.handleGoogleSignIn(
      onSuccess: () {
        if (mounted) {
          context.go(RouteNames.home);
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              backgroundColor: CustomAppColor.error,
            ),
          );
        }
      },
    );
  }

  void _handleForgotPassword() {
    _controller.handleForgotPassword(
      onEmailEmpty: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter your email first'),
              backgroundColor: CustomAppColor.warning,
            ),
          );
        }
      },
      onSuccess: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Password reset email sent! Please check your inbox.',
              ),
              backgroundColor: CustomAppColor.success,
            ),
          );
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              backgroundColor: CustomAppColor.error,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gaps.h40,
                        Text('NexaCloth', style: AppTextStyle.h3),
                        Text(
                          _controller.isLoginMode
                              ? 'welcome back'
                              : 'create your account',
                          style: AppTextStyle.subtextMedium,
                        ),

                        Gaps.h20,
                        // Email field (for both)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: AppTextStyle.custom(
                              fontWeight: FontWeight.w600,
                              fontSize: CustomFontSize.bodyMedium,
                              color: CustomAppColor.black,
                            ),
                          ),
                        ),
                        CustomTextField(
                          hintText: 'Enter your email',
                          controller: _controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _controller.validateEmail,
                        ),
                        Gaps.h8,
                        // Password field (for both)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: AppTextStyle.custom(
                              fontWeight: FontWeight.w600,
                              fontSize: CustomFontSize.bodyMedium,
                              color: CustomAppColor.black,
                            ),
                          ),
                        ),
                        CustomTextField(
                          hintText: 'Enter your password',
                          controller: _controller.passwordController,
                          obscureText: true,
                          validator: _controller.validatePassword,
                        ),

                        // Forgot password (only for login)
                        if (_controller.isLoginMode)
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: _handleForgotPassword,
                              child: Text(
                                'Forgot password?',
                                style: AppTextStyle.custom(
                                  fontWeight: FontWeight.w600,
                                  fontSize: CustomFontSize.bodyMedium,
                                  color: CustomAppColor.primary,
                                ),
                              ),
                            ),
                          ),
                        Gaps.h20,
                        CustomButton(
                          text: _controller.isLoginMode ? 'Login' : 'Register',
                          onPressed: _controller.isLoading
                              ? null
                              : _handleEmailAuth,
                        ),

                        if (_controller.isLoading) ...[
                          Gaps.h10,
                          const CircularProgressIndicator(),
                        ],

                        Gaps.h20,
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: CustomAppColor.greylight,
                                thickness: 1,
                              ),
                            ),
                            Gaps.w12,
                            Text('Or', style: AppTextStyle.subtextMedium),
                            Gaps.w12,
                            Expanded(
                              child: Divider(
                                color: CustomAppColor.greylight,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        Gaps.h10,
                        CustomGoogleCard(
                          onTap: _controller.isLoading
                              ? null
                              : _handleGoogleSignIn,
                        ),
                        Gaps.h10,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _controller.isLoginMode
                                    ? 'Don\'t have an account? '
                                    : 'Already have an account? ',
                                style: AppTextStyle.subtextMedium,
                              ),
                              TextSpan(
                                text: _controller.isLoginMode
                                    ? 'Sign up'
                                    : 'Login',
                                style: AppTextStyle.subtextMedium.copyWith(
                                  color: CustomAppColor.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _controller.isLoading
                                      ? null
                                      : _controller.toggleMode,
                              ),
                            ],
                          ),
                        ),
                        Gaps.h40,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
