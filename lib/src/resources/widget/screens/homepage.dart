import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:iotappver1/src/resources/widget/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../ServiceMQTT/MQTTManager.dart';
import '../../../ServiceMQTT/service_locator.dart';
import 'apps.dart';
import 'config_wifi.dart';
import 'home_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/main_app';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  void navigateToFivethPage() {
    setState(() {
      _currentIndex = 4;
    });
  }

  void navigateToFirstPage() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MQTTManager>(
      create: (context) => service_locator<MQTTManager>(),
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(
            () => _currentIndex = i,
          ),
          selectedItemColor: Colors.blue[500],
          unselectedItemColor: Colors.grey[400],
          selectedColorOpacity: 0.2,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 20,
              ),
              title: Text("Home"),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                Icons.grid_3x3,
                size: 20,
              ),
              title: Text("Apps"),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                Icons.add,
                size: 20,
              ),
              title: Text("Add"),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                Icons.notifications,
                size: 20,
              ),
              title: Text("Notifi"),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.solidUser,
                size: 20,
              ),
              title: Text("Profile"),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(navigateToFivethPage: navigateToFivethPage),
            Apps(
              navigateToFivethPage: navigateToFivethPage,
              navigateToFirstPage: navigateToFirstPage,
            ),
            ConfigWifiPage(),
            Container(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
