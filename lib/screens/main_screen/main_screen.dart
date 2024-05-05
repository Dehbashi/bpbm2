import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/screens/about_us_screen/about_us_screen.dart';
import 'package:bpbm2/screens/contact_screen/contact_screen.dart';
import 'package:bpbm2/screens/faq_screen/faq_screen.dart';
import 'package:bpbm2/screens/home_screen/home_screen.dart';
import 'package:bpbm2/screens/main_screen/methods/navigator_method.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_app_bar.dart';
import 'package:bpbm2/screens/main_screen/widgets/main_screen_drawer.dart';
import 'package:bpbm2/screens/profile_screen/profile_drawer/profile_drawer_screen.dart';
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
  ScrollController _scrollController = ScrollController();
  final ScrollController _homeScrollController = ScrollController();
  final ScrollController _contactScrollController = ScrollController();
  final ScrollController _aboutUsScrollController = ScrollController();
  final ScrollController _faqScrollController = ScrollController();
  // final ScrollController _profileScrollController = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _contactKey = GlobalKey();
  GlobalKey<NavigatorState> _aboutUsKey = GlobalKey();
  GlobalKey<NavigatorState> _faqKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    0: _homeKey,
    1: _contactKey,
    2: _aboutUsKey,
    3: _faqKey,
    4: _profileKey,
  };

  bool appClose = false;

  void onWillPop(bool didPop) async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[currentIndex]!.currentState!;
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.closeDrawer();
    } else if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      _scaffoldKey.currentState!.closeEndDrawer();
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

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void switchIndex() {
    switch (currentIndex) {
      case 0:
        _navigatorKey = _homeKey;
        _scrollController = _homeScrollController;
        break;
      case 1:
        _navigatorKey = _contactKey;
        _scrollController = _contactScrollController;
        break;
      case 2:
        _navigatorKey = _aboutUsKey;
        _scrollController = _aboutUsScrollController;
        break;
      case 3:
        _navigatorKey = _faqKey;
        _scrollController = _faqScrollController;
        break;
      case 4:
        _navigatorKey = _profileKey;
        // _scrollController = _profileScrollController;
        break;
      default:
        _navigatorKey = _homeKey;
        _scrollController = _homeScrollController;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onInsideLinkTapped(int newIndex) {
      if (currentIndex != newIndex) {
        setState(() {
          _history.remove(currentIndex);
          _history.add(currentIndex);
          currentIndex = newIndex;
        });
      }
    }

    switchIndex();

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
        child: ContactScreen(
          scrollController: _contactScrollController,
          onFaqTapped: onInsideLinkTapped,
        ),
      ),
      navigatorMethod(
        key: _aboutUsKey,
        index: 2,
        currentIndex: currentIndex,
        child: AboutUsScreen(
          scrollController: _scrollController,
        ),
      ),
      navigatorMethod(
        key: _faqKey,
        index: 3,
        currentIndex: currentIndex,
        child: FaqScreen(
          scrollController: _scrollController,
          onAboutUsTapped: onInsideLinkTapped,
        ),
      ),
      navigatorMethod(
        key: _profileKey,
        index: 4,
        currentIndex: currentIndex,
        child: const ProfileScreen(),
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: const MainScreenAppBar(),
        drawer: MainScreenDrawer(
          navKey: _navigatorKey,
          scaffoldKey: _scaffoldKey,
          onDrawerQuickLinkTapped: onInsideLinkTapped,
        ),
        endDrawer: ProfileDrawerScreen(
          navKey: _navigatorKey,
          scaffoldKey: _scaffoldKey,
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: bottomNavBarItem,
          onTap: (index) {
            if (index != 4) {
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
            } else {
              _scaffoldKey.currentState!.openEndDrawer();
            }
          },
        ),
      ),
    );
  }
}
