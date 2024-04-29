import 'package:flutter/material.dart';

class MainScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final GlobalKey<ScaffoldState> scaffoldKey;
  const MainScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      title: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Image.asset(
          'assets/images/logo.png',
          width: 130,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
