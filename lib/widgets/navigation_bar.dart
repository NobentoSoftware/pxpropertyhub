import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../screens/home_screen.dart';

import '../screens/pxstay_screen.dart';
import '../screens/pxproperty_screen.dart';

class NavBarMenu extends StatefulWidget{
  const NavBarMenu({
      Key? key,
      required this.pagename
      })
      : super(key: key);

  final int pagename;

  @override
  State<NavBarMenu> createState() => _NavBarMenuState(pagename: this.pagename);
}

class _NavBarMenuState extends State<NavBarMenu>{

  _NavBarMenuState({required this.pagename});

  final int pagename;
  int selectedTap = 0;
  @override
  void initState() {
    super.initState();
    selectedTap = pagename;
  }

  static const IconData bed_double_fill = IconData(0xf589, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData building_2_fill = IconData(0xf8b5, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData house_alt_fill = IconData(0xf8e4, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);

  bool isChangeColor = true;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: isChangeColor ? Colors.blueAccent : Colors.white,
      //type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      onTap: (index){
        if(index == 0){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const HomeScreen(),
            ),
          );
        }else if(index == 1){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PXStayScreen(listing_category: "rememver"),
            ),
          );
        }else if(index == 2){
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const PXPropertyScreen(listing_category: "home"),
            ),
          );
        }
        //print("Selected: "+index.toString());
      },
      currentIndex: selectedTap,
      items: const[
        BottomNavigationBarItem(
          icon: Icon(house_alt_fill),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(bed_double_fill),
            label: 'PX Stay'
        ),
        BottomNavigationBarItem(
            icon: Icon(building_2_fill),
            label: 'PX Property'
        ),
      ],);
  }
}