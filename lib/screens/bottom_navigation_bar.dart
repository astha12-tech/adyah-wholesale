// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/screens/cart_screen/cart_screen.dart';
import 'package:adyah_wholesale/screens/category_screen/category_screen.dart';
import 'package:adyah_wholesale/screens/home_screen/homescreen.dart';
import 'package:adyah_wholesale/screens/setting_screen/setting_screen.dart';
import 'package:adyah_wholesale/screens/my_orders/my_order_history_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  int? currentIndex;
  final VoidCallback toggleTheme;
  BottomNavigationBarScreen(
      {super.key, this.currentIndex, required this.toggleTheme});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.currentIndex != null) {
      _selectedIndex = widget.currentIndex!;
    }
    super.initState();
  }

  List<Widget> screens = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen(toggleTheme: widget.toggleTheme);
      case 1:
        return const OrderHistoryScreen();
      case 2:
        return CategoryScreen(toggleTheme: widget.toggleTheme);
      case 3:
        return CartScreenn(
          allcartDataids: SpUtil.getString(SpConstUtil.cartID)!,
          title: 'BottomBar',
          toggleTheme: widget.toggleTheme,
        );
      case 4:
        return SettingScreen(toggleTheme: widget.toggleTheme);
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavyBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedIndex: _selectedIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: <BottomNavyBarItem>[
        _buildBottomNavigationBarItem('assets/png/home.png', 'Home', 0),
        _buildBottomNavigationBarItem('assets/png/history.png', 'My Orders', 1),
        _buildBottomNavigationBarItem(
            'assets/png/categories.png', 'Categories', 2),
        _buildBottomNavigationBarItem(
            'assets/png/shopping-cart.png', 'Cart', 3),
        _buildBottomNavigationBarItem('assets/png/people.png', 'My Profile', 4),
      ],
    );
  }

  BottomNavyBarItem _buildBottomNavigationBarItem(
      String imagePath, String title, int index) {
    bool isCart = index == 3;
    return BottomNavyBarItem(
      icon: isCart ? _buildCartIcon(imagePath) : _buildIcon(imagePath),
      title: Text(title),
      activeColor: SpUtil.getBool(SpConstUtil.appTheme)!
          ? colors.whitecolor
          : colors.themebluecolor,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildIcon(String imagePath) {
    return Image.asset(
      imagePath,
      height: 25,
      width: 25,
      color: SpUtil.getBool(SpConstUtil.appTheme)!
          ? colors.whitecolor
          : colors.themebluecolor,
    );
  }

  Widget _buildCartIcon(String imagePath) {
    return _buildIcon(imagePath);
  }
}
