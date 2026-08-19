import 'package:findit/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_header.dart';
import '../widgets/google_sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.initialEmail,
    this.initialPassword,
  });

  final String? initialEmail;
  final String? initialPassword;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  
@override
void initState() {
  super.initState();

  _emailController.text = widget.initialEmail ?? '';
  _passwordController.text = widget.initialPassword ?? '';
}
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // سيتم ربط Firebase لاحقًا.
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم ربط تسجيل الدخول لاحقًا.'),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    // سيتم ربط Google Sign-In لاحقًا.
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      _isGoogleLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم ربط تسجيل الدخول عبر Google لاحقًا.'),
      ),
    );
  }

  void _forgotPassword() {
    // سيتم الانتقال إلى صفحة استعادة كلمة المرور لاحقًا.
    Navigator.pushNamed(
    context,
    AppRoutes.forgotPassword,
  );
  }

  void _createAccount() {
     Navigator.pushNamed(
    context,
    '/register',
  );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 420,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AuthHeader(
                        title: 'مرحبًا بعودتك',
                        subtitle: 'سجّل الدخول للمتابعة باستخدام FindIt',
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      AppTextField(
                        controller: _emailController,
                        label: 'البريد الإلكتروني',
                        hint: 'أدخل بريدك الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        validator: Validators.email,
                       
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      AppTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        hint: 'أدخل كلمة المرور',
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          tooltip: _obscurePassword
                              ? 'إظهار كلمة المرور'
                              : 'إخفاء كلمة المرور',
                        ),
                        validator: (value) {
                          final error = Validators.required(
                            value,
                            field: 'كلمة المرور',
                          );

                          if (error != null) {
                            return error;
                          }

                          if (value!.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: _forgotPassword,
                          child: const Text(
                            'هل نسيت كلمة المرور؟',
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      AppPrimaryButton(
                        text: 'تسجيل الدخول',
                        onPressed: _login,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      const AuthDivider(
                        text: 'أو',
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      GoogleSignInButton(
                        onPressed: _signInWithGoogle,
                        isLoading: _isGoogleLoading,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextButton(
                            onPressed: _createAccount,
                            child: const Text(
                              'إنشاء حساب',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}