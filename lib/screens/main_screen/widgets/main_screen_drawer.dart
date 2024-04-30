import 'package:bpbm2/blocs/service_list_bloc/service_list_bloc.dart';
import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_drawer_header.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_drawer_quick_link.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_drawer_service_list_widget.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_drawer_social_media_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenDrawer extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MainScreenDrawer({
    super.key,
    required this.navKey,
    required this.scaffoldKey,
  });

  @override
  State<MainScreenDrawer> createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer>
    with SingleTickerProviderStateMixin {
  bool showAllItems = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ServiceListBloc>(context).add(
      ServiceListStarted(
        context: context,
      ),
    );
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainScreenDrawerHeader(),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                ),
                BlocBuilder<ServiceListBloc, ServiceListState>(
                  builder: (context, state) {
                    if (state is ServiceListFailed) {
                      return const Center(
                        child: Text('خطا در دریافت لیست خدمات'),
                      );
                    } else if (state is ServiceListSuccessful) {
                      final serviceList = state.serviceList;
                      return SizedBox(
                        height: 270,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            physics: scrollPhysics,
                            itemCount: serviceList.length,
                            itemBuilder: (context, index) {
                              final service = serviceList[index];
                              final imagePath =
                                  'assets/icons/homeicons/${service.id}.webp';
                              if (index <= 5 || showAllItems) {
                                return MainScreenDrawerServiceListWidget(
                                  service: service,
                                  imagePath: imagePath,
                                  navKey: widget.navKey,
                                  scaffoldKey: widget.scaffoldKey,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAllItems = !showAllItems;
                      showAllItems
                          ? _animationController.forward()
                          : _animationController.reverse();
                    });
                  },
                  child: Text(
                    showAllItems ? 'موارد کمتر' : 'موارد بیشتر ...',
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                ),
                MainScreenDrawerQuickLink(
                  navKey: widget.navKey,
                  scaffoldKey: widget.scaffoldKey,
                ),
                MainScreenDrawerSocialMediaLink(
                  scaffoldKey: widget.scaffoldKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
