import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:valuenotifier_valuelistenablebuilder/pages/community.dart';
import 'package:valuenotifier_valuelistenablebuilder/pages/notifiaction.dart';

import 'pages/profile.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> titleIndex = ValueNotifier('Community');

  final pages = const [
    CommunityPage(),
    ProfilePage(),
    NotificationPage(),
  ];

  final title = const [
    'Community',
    'Profile',
    'Notification',
  ];

  void _NavigationItemSelected(index) {
    titleIndex.value = title[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
          valueListenable: titleIndex,
          builder: (BuildContext context, String value, Widget? child) {
            return Text(
              titleIndex.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
        leading: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            // splashColor: AppColors.secondary,
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                IconlyLight.search,
                size: 22,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 21.0),
            child: Text('pic'),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: ((BuildContext context, int value, _) {
          return pages[value];
        }),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _NavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  int selectedItemIndex = 0;

  void selectedItemOnTap(int index) {
    setState(() {
      selectedItemIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                icon: IconlyBold.chat,
                onTap: selectedItemOnTap,
                isSelected: selectedItemIndex == 0,
              ),
              _NavigationBarItem(
                index: 1,
                icon: IconlyBold.profile,
                onTap: selectedItemOnTap,
                isSelected: selectedItemIndex == 1,
              ),
              _NavigationBarItem(
                index: 2,
                icon: Icons.notifications,
                onTap: selectedItemOnTap,
                isSelected: selectedItemIndex == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
    required this.index,
  }) : super(key: key);

  final IconData icon;
  final int index;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 50,
        child: Icon(
          icon,
          size: 34,
        ),
      ),
    );
  }
}
