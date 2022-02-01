import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final Function ontap;
  const MyBottomNavigationBar({
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      elevation: 10,
      onTap: (index) => widget.ontap(index),
      selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary,opacity: 1),
      selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary,),
      showUnselectedLabels: false,
      unselectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),
      unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary,opacity: 0.5),
      items: [
        
      ]);
  }
}