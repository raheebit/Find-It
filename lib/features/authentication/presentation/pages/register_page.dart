import 'package:findit/features/authentication/presentation/pages/login_page.dart';
import 'package:findit/features/authentication/presentation/widgets/email_verification_dialog.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 Future<void> _register() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    _isLoading = true;
  });

  // سيتم استبدال هذا الجزء بإنشاء الحساب في Firebase.
  await Future<void>.delayed(
    const Duration(milliseconds: 700),
  );

  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  final email = _emailController.text.trim();

  final verificationCompleted =
      await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return EmailVerificationDialog(
        email: email,
        onCheckVerification: () async {
          // مؤقتًا: Firebase سيقوم بالتحقق الحقيقي لاحقًا.
          await Future<void>.delayed(
            const Duration(milliseconds: 500),
          );

          return false;
        },
        onResendEmail: () async {
          // مؤقتًا: سيتم ربطها بـ Firebase لاحقًا.
          await Future<void>.delayed(
            const Duration(milliseconds: 500),
          );
        },
      );
    },
  );

  if (!mounted) return;

  if (verificationCompleted == true) {
   Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => LoginPage(
      initialEmail: email,
      initialPassword: _passwordController.text,
    ),
  ),
);
  }
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
        content: Text(
          'سيتم ربط التسجيل عبر Google لاحقًا.',
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      title: 'إنشاء حساب',
                      subtitle:
                          'أنشئ حسابك وابدأ باستخدام FindIt',
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    AppTextField(
                      controller: _nameController,
                      label: 'الاسم',
                      hint: 'أدخل اسمك',
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                      ),
                      validator: (value) {
                        final error = Validators.required(
                          value,
                          field: 'الاسم',
                        );

                        if (error != null) {
                          return error;
                        }

                        if (value!.trim().length < 2) {
                          return 'يجب أن يكون الاسم حرفين على الأقل';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.lg),

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
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword =
                                !_obscurePassword;
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

                    const SizedBox(height: AppSpacing.lg),

                    AppTextField(
                      controller: _confirmPasswordController,
                      label: 'تأكيد كلمة المرور',
                      hint: 'أعد إدخال كلمة المرور',
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        tooltip: _obscureConfirmPassword
                            ? 'إظهار كلمة المرور'
                            : 'إخفاء كلمة المرور',
                      ),
                      validator: (value) {
                        final error = Validators.required(
                          value,
                          field: 'تأكيد كلمة المرور',
                        );

                        if (error != null) {
                          return error;
                        }

                        if (value != _passwordController.text) {
                          return 'كلمتا المرور غير متطابقتين';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    AppPrimaryButton(
                      text: 'إنشاء الحساب',
                      onPressed: _register,
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
                          'لديك حساب بالفعل؟',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: _goToLogin,
                          child: const Text(
                            'تسجيل الدخول',
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
    );
  }
}