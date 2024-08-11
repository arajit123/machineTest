
import 'package:flutter/material.dart';

import 'package:machine_test/provider/changescreen.dart';
import 'package:machine_test/screens/bottomnavbar/bottomnavbar.dart';
import 'package:machine_test/screens/cart/cart.dart';
import 'package:machine_test/screens/categories/categories.dart';
import 'package:machine_test/screens/deals/deals.dart';
import 'package:machine_test/screens/homepage/home_page.dart';
import 'package:machine_test/screens/profile/profile.dart';
import 'package:provider/provider.dart';


class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<Widget> pageList = const [
   HomePage(),
   Categories(),
   Dealspage(),
   Cart(),
   ProfilePage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}