import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  const AppBarWidget({
    Key? key,
    required this.title,
    this.actions,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: onPressed != null ?
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20,),
        onPressed: onPressed!,
      ) : null,
    );
  }
}