import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
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

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('تم إرسال الرابط'),
          content: Text(
            'تم إرسال رابط إعادة تعيين كلمة المرور إلى:\n\n'
            '${_emailController.text.trim()}\n\n'
            'تحقق من بريدك الإلكتروني واتبع التعليمات الموجودة في الرسالة.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(this.context);
              },
              child: const Text('العودة لتسجيل الدخول'),
            ),
          ],
        );
      },
    );
  }

  void _backToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _backToLogin,
          icon: const Icon(
            Icons.arrow_forward_rounded,
          ),
          tooltip: 'العودة',
        ),
      ),
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
                      title: 'نسيت كلمة المرور؟',
                      subtitle:
                          'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.',
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    AppTextField(
                      controller: _emailController,
                      label: 'البريد الإلكتروني',
                      hint: 'أدخل بريدك الإلكتروني',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      validator: Validators.email,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    AppPrimaryButton(
                      text: 'إرسال رابط إعادة التعيين',
                      onPressed: _sendResetLink,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    TextButton.icon(
                      onPressed: _backToLogin,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                      ),
                      label: const Text(
                        'العودة إلى تسجيل الدخول',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        textStyle: AppTextStyles.bodyMedium,
                      ),
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