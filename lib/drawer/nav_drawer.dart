// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:taskwarrior/config/app_settings.dart';
import 'package:taskwarrior/model/storage/storage_widget.dart';
import 'package:taskwarrior/views/about/about.dart';
import 'package:taskwarrior/views/profile/profile.dart';
import 'package:taskwarrior/views/reports/reports_home.dart';
import 'package:taskwarrior/config/theme_switcher_clipper.dart';
import 'package:taskwarrior/views/settings/settings.dart';

class NavDrawer extends StatefulWidget {
  final InheritedStorage storageWidget;
  final Function() notifyParent;

  const NavDrawer({
    Key? key,
    required this.storageWidget,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppSettings.isDarkMode ? Colors.black : Colors.white,
      child: Container(
        color: AppSettings.isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: AppSettings.isDarkMode ? Colors.black : Colors.white,
              padding: const EdgeInsets.only(top: 50, left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:
                          AppSettings.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ThemeSwitcherClipper(
                      isDarkMode: AppSettings.isDarkMode,
                      onTap: (bool newMode) async {
                        AppSettings.isDarkMode = newMode;
                        setState(() {});
                        await SelectedTheme.saveMode(AppSettings.isDarkMode);
                        widget.notifyParent();
                      },
                      child: Icon(
                        AppSettings.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: AppSettings.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppSettings.isDarkMode ? Colors.black : Colors.white,
              height: 3.h,
            ),
            buildMenuItem(
              icon: Icons.person_rounded,
              text: 'Profile',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
                // Navigator.pushNamed(context, PageRoutes.profile);
              },
            ),
            buildMenuItem(
              icon: Icons.summarize,
              text: 'Reports',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReportsHome(),
                  ),
                );
              },
            ),
            buildMenuItem(
              icon: Icons.info,
              text: 'About',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
            buildMenuItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppSettings.isDarkMode ? Colors.black : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppSettings.isDarkMode ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: AppSettings.isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
