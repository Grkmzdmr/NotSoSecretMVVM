import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/main/home/home_page.dart';
import 'package:not_so_secret/presentation/main/profile/profile_page.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    //NotificationPage(),
    ProfilePageTest()
  ];
  List<String> titles = [
    AppStrings.home.tr(),

    //AppStrings.notification,
    AppStrings.person.tr()
  ];
  var _title = AppStrings.home.tr();
  var _currentIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppBar(context, _title),
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        child: Center(
            child: Icon(
          Icons.add,
          size: AppSize.s32,
        )),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addSecretRoute);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: AppSize.s6,
        child: Container(
            height: AppSize.s60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 20,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: _currentIndex == 0
                              ? ColorManager.primary
                              : ColorManager.darkGrey,
                          size: AppSize.s32,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: _currentIndex == 0
                              ? ColorManager.darkGrey
                              : ColorManager.primary,
                          size: AppSize.s32,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),

    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}

PreferredSizeWidget _homeAppBar(BuildContext context, String _title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      _title,
      style: Theme.of(context).textTheme.headline2,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.settingsRoute);
        },
      ),
    ],
  );
}
