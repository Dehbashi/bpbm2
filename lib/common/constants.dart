import 'package:flutter/material.dart';

const baseUrl = 'https://s1.lianerp.com/api/public';

const baseAssetUrl = 'https://bespareshbema.com/assets/services';

const defaultScrollPhysics = BouncingScrollPhysics();

const List<BottomNavigationBarItem> bottomNavBarItem = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'خانه',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.headset_mic),
    label: 'ارتباط با ما',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_3_outlined),
    label: 'همکاری',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.message),
    label: 'پیام',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_2),
    label: 'پروفایل کاربری',
  ),
];
