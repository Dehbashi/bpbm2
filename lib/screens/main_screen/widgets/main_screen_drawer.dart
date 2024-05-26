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
  final Function onDrawerQuickLinkTapped;
  const MainScreenDrawer({
    super.key,
    required this.navKey,
    required this.scaffoldKey,
    required this.onDrawerQuickLinkTapped,
  });

  @override
  State<MainScreenDrawer> createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer>
    with SingleTickerProviderStateMixin {
  bool showAllItems = false;
  late AnimationController _animationController;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ServiceListBloc>(context).add(
      ServiceListStarted(
        context: context,
      ),
    );
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
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: defaultScrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainScreenDrawerHeader(),
                const Divider(),
                BlocBuilder<ServiceListBloc, ServiceListState>(
                  builder: (context, state) {
                    if (state is ServiceListFailed) {
                      return const Center(
                        child: Text('خطا در دریافت لیست خدمات'),
                      );
                    } else if (state is ServiceListSuccessful) {
                      final serviceList = state.serviceList;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: showAllItems ? 400 : 260,
                        child: Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          child: ListView.builder(
                            controller: ScrollController(),
                            physics: defaultScrollPhysics,
                            itemCount: serviceList.length,
                            itemBuilder: (context, index) {
                              final service = serviceList[index];
                              final imagePath =
                                  'assets/icons/homeicons/${service.id}.webp';
                              if ((index <= 5 || showAllItems) &&
                                  service.title != 'سایر' &&
                                  service.title != 'پسیو شبکه های کامپیوتری') {
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Divider(),
                MainScreenDrawerQuickLink(
                  navKey: widget.navKey,
                  scaffoldKey: widget.scaffoldKey,
                  onDrawerQuickLinkTapped: widget.onDrawerQuickLinkTapped,
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
