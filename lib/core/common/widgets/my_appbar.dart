import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnTap,
    this.showRefresh = true,
  });

  final Widget? title;
  final bool showRefresh;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showRefresh
            ? IconButton(
                icon: Icon(leadingIcon ?? Icons.refresh, color: Colors.black),
                onPressed: leadingOnTap ?? () => Navigator.pop(context),
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((AppBar().preferredSize.height));
}
