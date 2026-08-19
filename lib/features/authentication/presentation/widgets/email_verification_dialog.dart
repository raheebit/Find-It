import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

class EmailVerificationDialog extends StatefulWidget {
  const EmailVerificationDialog({
    super.key,
    required this.email,
    required this.onCheckVerification,
    required this.onResendEmail,
  });

  final String email;
  final Future<bool> Function() onCheckVerification;
  final Future<void> Function() onResendEmail;

  @override
  State<EmailVerificationDialog> createState() =>
      _EmailVerificationDialogState();
}

class _EmailVerificationDialogState
    extends State<EmailVerificationDialog> {
  bool _isChecking = false;
  bool _isResending = false;
  String? _errorMessage;
  String? _successMessage;

  Future<void> _checkVerification() async {
    setState(() {
      _isChecking = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final isVerified = await widget.onCheckVerification();

      if (!mounted) return;

      if (isVerified) {
        Navigator.of(context).pop(true);
        return;
      }

      setState(() {
        _errorMessage =
            'لم يتم تفعيل بريدك الإلكتروني بعد.\n'
            'يرجى تفعيل البريد ثم المحاولة مرة أخرى.';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'حدث خطأ أثناء التحقق من البريد الإلكتروني.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  Future<void> _resendEmail() async {
    setState(() {
      _isResending = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await widget.onResendEmail();

      if (!mounted) return;

      setState(() {
        _successMessage =
            'تمت إعادة إرسال رسالة التفعيل إلى بريدك الإلكتروني.';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'تعذر إعادة إرسال رسالة التفعيل. حاول مرة أخرى.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(
          'فعّل بريدك الإلكتروني',
          style: AppTextStyles.title,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 56,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'أرسلنا رابط تفعيل إلى:',
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.email,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'افتح بريدك الإلكتروني واضغط على رابط التفعيل، '
                'ثم عد إلى التطبيق واضغط على "تم التفعيل".',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
              if (_successMessage != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _successMessage!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isChecking || _isResending
                  ? null
                  : _checkVerification,
              child: _isChecking
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('تم التفعيل'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: _isChecking || _isResending
                ? null
                : _resendEmail,
            child: _isResending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Text('إعادة إرسال رسالة التفعيل'),
          ),
        ],
      ),
    );
  }
}