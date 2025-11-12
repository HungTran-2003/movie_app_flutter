import 'package:flutter/material.dart';
import 'package:movie_app/common/app_dimens.dart';
import 'package:movie_app/common/app_text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyle.whiteMontS16SemiBold,),
      centerTitle: true,
      leading: onPressed != null ?
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20,),
        color: Colors.white,
        onPressed: onPressed!,
      ) : null,
      actions: actions,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}