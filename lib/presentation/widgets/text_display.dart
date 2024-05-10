import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persona/presentation/styles/text_styles.dart';

class UserDetailText extends StatelessWidget {
  final String title;
  final String trailing;
  const UserDetailText(
      {super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(trailing, style: AppTextStyles.subtitle1),
        ],
      ),
    );
  }
}
