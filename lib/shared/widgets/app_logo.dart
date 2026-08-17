import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.iconSize = 42,
  });

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(iconSize * 0.25),
          ),
          child: Icon(
            Icons.search_rounded,
            size: iconSize * 0.55,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'FindIt',
          style: AppTextStyles.headline,
        ),
      ],
    );
  }
}