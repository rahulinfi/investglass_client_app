import 'package:flutter/material.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';
import '../market/market.dart';
import '../portfolio/posrfolio.dart';
import '../profile/profile.dart';
import '../proposals/proposals.dart';
import '../utils/app_colors.dart';
import '../utils/app_widgets.dart';
import 'dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late PageController controller;

  late DashboardController _controller;

  @override
  void initState() {
    controller=PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _controller=Provider.of<DashboardController>(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.bg,
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: AppColors.kTextFieldInput,showUnselectedLabels:true ,
              selectedItemColor: AppColors.kViolate,onTap: (value) {
                _controller.changeIndex(value);
                controller.animateToPage(value, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
                // controller=PageController(initialPage: value);
              },
              currentIndex: _controller.selectedIndex,
              items: List<BottomNavigationBarItem>.generate(AppConst.titleList.length,(index) {
                return BottomNavigationBarItem(icon: Image.asset('assets/${AppConst.titleList[index].toLowerCase()}.png',scale: 25,color: _controller.selectedIndex==index?AppColors.kViolate:AppColors.kTextFieldInput,),label: AppConst.titleList[index]);
              },),
            ),
          )
      ),
      appBar: AppWidgets.appBar(AppConst.titleList[_controller.selectedIndex],leading: GestureDetector(
        onTap: (){
          _scaffoldkey.currentState!.openDrawer();
        },
        child: Icon(
          Icons.menu,
          color: AppColors.kTextFieldInput,
        ),
      )),
      drawer: AppWidgets.drawer((i){
          _scaffoldkey.currentState!.closeDrawer();
          _controller.changeIndex(i);
          controller.animateToPage(i, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
          // controller=PageController(initialPage: value);
      }),
      body: PageView(
        controller: controller,physics: NeverScrollableScrollPhysics(),
        children: const [
          Home(),
          Portfolio(),
          Market(),
          Proposals(),
          Profile(),
        ],
        onPageChanged: (page) {

        },
      ),
    );
  }
}
