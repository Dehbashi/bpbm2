import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_user_screen_item.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/profile_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUserScreen extends StatelessWidget {
  final String cellNumber;
  const DrawerUserScreen({super.key, required this.cellNumber});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> userDrawerItems = [
      {'داشبورد': Icons.bar_chart},
      {'سفارش های من': Icons.view_list},
      {'آدرس های من': Icons.location_on},
      {'مشخصات کاربری': Icons.person},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 20, 80),
      child: Column(
        children: [
          ProfileDrawerHeader(
            icon: Icons.verified_user,
            text: 'کاربر: $cellNumber',
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userDrawerItems.length,
              itemBuilder: (context, index) {
                final userItem = userDrawerItems[index];
                return DrawerUserScreenItem(
                  onTap: () {},
                  icon: userItem.values.first,
                  text: userItem.keys.first,
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(
                AuthSignOut(context: context),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Text(
                    'خروج کاربر',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
