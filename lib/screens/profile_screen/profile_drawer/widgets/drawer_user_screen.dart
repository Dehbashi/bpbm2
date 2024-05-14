import 'package:bpbm2/blocs/auth_bloc/auth_bloc.dart';
import 'package:bpbm2/blocs/user_order_bloc/user_order_bloc.dart';
import 'package:bpbm2/common/dialogs/generic_dialog.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/drawer_user_screen_item.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/widgets/profile_drawer_header.dart';
import 'package:bpbm2/screens/user_address_screen/user_address_screen.dart';
import 'package:bpbm2/screens/user_dashboard_screen/user_dashboard_screen.dart';
import 'package:bpbm2/screens/user_order_screen/user_order_screen.dart';
import 'package:bpbm2/screens/user_profile_screen/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUserScreen extends StatelessWidget {
  final String cellNumber;
  final GlobalKey<NavigatorState> navKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerUserScreen({
    super.key,
    required this.cellNumber,
    required this.navKey,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, Map<Widget, dynamic>>> userDrawerItems = [
      {
        'داشبورد': {const UserDashboardScreen(): Icons.bar_chart}
      },
      {
        'سفارش های من': {
          BlocProvider(
            create: (context) => UserOrderBloc(context),
            child: const UserOrderScreen(),
          ): Icons.view_list
        }
      },
      {
        'آدرس های من': {const UserAddressScreen(): Icons.location_on}
      },
      {
        'مشخصات کاربری': {const UserProfileScreen(): Icons.person}
      },
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
                  onTap: () {
                    scaffoldKey.currentState!.closeEndDrawer();
                    navKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => userItem.values.first.keys.first,
                      ),
                    );
                  },
                  icon: userItem.values.first.values.first,
                  text: userItem.keys.first,
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              showGenericDialog<bool>(
                context: context,
                title: 'خروج',
                content: 'آیا از خروج خود اطمینان دارید؟',
                optionsBuilder: () => {
                  'بله': true,
                  'خیر': false,
                },
              ).then((result) {
                if (result != null && result) {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthSignOut(context: context),
                  );
                }
              });
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
