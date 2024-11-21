import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '', // Handle null title
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: actions ?? [], // Handle null actions
      backgroundColor: Colors.white, // Optional: Better contrast
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
