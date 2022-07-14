import 'package:estatio/src/sample_feature/sample_item_details_view.dart';
import 'package:estatio/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class IndexPageView extends StatefulWidget {
  final SettingsController settingsController;
  const IndexPageView({
    Key? key,
    required this.settingsController,
  }) : super(key: key);
  static const routeName = '/';
  @override
  State<IndexPageView> createState() => _IndexPageViewState();
}

class _IndexPageViewState extends State<IndexPageView> {
  final _controller = PersistentTabController(initialIndex: 0);
  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [
      const Text('Screen 1'),
      const SampleItemListView(),
      const Text('Notifications Screen'),
      const Text('DataBase Screen'),
      const Text('Extras Screen')
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people),
        title: ("landlords"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/landlords': (context) => const SampleItemListView(),
            '/landlord/details': (context) =>  const SampleItemDetailsView(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: "Alerts",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.analytics),
        title: "Records",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.construction),
        title: "Extras",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? appBarTitle = _navBarsItems().elementAt(_selectedIndex).title;
    var appBarIcon = _navBarsItems().elementAt(_selectedIndex).icon;
    return Scaffold(
      appBar: AppBar(
        leading: appBarIcon,
        title: Text(appBarTitle ?? 'Welcome!'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children:  const <Widget> [
            Image(image: AssetImage('assets/images/flutter_logo.png'))
          ],      
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
