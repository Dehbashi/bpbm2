import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/screens/collaboration_screen/collaboration_screen.dart';
import 'package:bpbm2/screens/contact_screen/contact_screen.dart';
import 'package:bpbm2/screens/home_screen/home_screen.dart';
import 'package:bpbm2/screens/main_screen/methods/navigator_method.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_app_bar.dart';
import 'package:bpbm2/screens/message_screen/message_screen.dart';
import 'package:bpbm2/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<int> _history = [];
  final ScrollController _scrollController = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _contactKey = GlobalKey();
  GlobalKey<NavigatorState> _collaborationKey = GlobalKey();
  GlobalKey<NavigatorState> _messageKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    0: _homeKey,
    1: _contactKey,
    2: _collaborationKey,
    3: _messageKey,
    4: _profileKey,
  };

  bool appClose = false;

  void onWillPop(bool didPop) async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[currentIndex]!.currentState!;
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.closeDrawer();
    } else {
      if (currentSelectedTabNavigatorState.canPop()) {
        appClose = false;
        currentSelectedTabNavigatorState.pop();
      } else if (_history.isNotEmpty) {
        setState(() {
          currentIndex = _history.last;
          _history.removeLast();
        });
        appClose = false;
      } else {
        appClose = true;
      }
      if (appClose) {
        SystemNavigator.pop();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      navigatorMethod(
        key: _homeKey,
        index: 0,
        currentIndex: currentIndex,
        child: HomeScreen(
          scrollController: _scrollController,
        ),
      ),
      navigatorMethod(
        key: _contactKey,
        index: 1,
        currentIndex: currentIndex,
        child: const ContactScreen(),
      ),
      navigatorMethod(
        key: _collaborationKey,
        index: 2,
        currentIndex: currentIndex,
        child: const CollaborationScreen(),
      ),
      navigatorMethod(
        key: _messageKey,
        index: 3,
        currentIndex: currentIndex,
        child: const MessageScreen(),
      ),
      navigatorMethod(
        key: _profileKey,
        index: 4,
        currentIndex: currentIndex,
        child: const ProfileScreen(),
      ),
    ];

    switch (currentIndex) {
      case 0:
        _navigatorKey = _homeKey;
        break;
      case 1:
        _navigatorKey = _contactKey;
        break;
      case 2:
        _navigatorKey = _collaborationKey;
        break;
      case 3:
        _navigatorKey = _messageKey;
        break;
      case 4:
        _navigatorKey = _profileKey;
        break;
      default:
        _navigatorKey = _homeKey;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: const MainScreenAppBar(),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: bottomNavBarItem,
          onTap: (index) {
            final NavigatorState currentSelectedTabNavigatorState =
                map[currentIndex]!.currentState!;
            if (index == currentIndex) {
              if (currentSelectedTabNavigatorState.canPop()) {
                currentSelectedTabNavigatorState.popUntil((_) {
                  return !currentSelectedTabNavigatorState.canPop();
                });
              } else {
                scrollToTop();
              }
              return;
            }
            setState(() {
              _history.remove(currentIndex);
              _history.add(currentIndex);
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
