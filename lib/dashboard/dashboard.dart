import 'package:flutter/material.dart';
import 'package:kleber_bank/main.dart';
import 'package:kleber_bank/portfolio/portfolio.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:kleber_bank/utils/app_styles.dart';
import 'package:kleber_bank/utils/shared_pref_utils.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';
import '../market/market.dart';
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
    if (AppConst.userModel!=null) {
      SharedPrefUtils.instance.putString(USER_DATA, AppConst.userModel!.toRawJson());
    }
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<DashboardController>(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.bg,
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: AppConst.titleList.map<Widget>(
                (e) {
                  return GestureDetector(
                    onTap: () {
                      _controller.changeIndex(AppConst.titleList.indexOf(e));
                      controller.animateToPage(AppConst.titleList.indexOf(e), duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
                    },
                    child: Wrap(
                      direction: Axis.vertical, alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: rSize * 0.008,
                        ),
                        Image.asset(
                          'assets/${e.toLowerCase()}.png',
                          scale: 25,
                          color: AppConst.titleList[_controller.selectedIndex] == e ? AppColors.kViolate : AppColors.kTextFieldInput,
                        ),
                        Text(
                          e,
                          style: AppConst.titleList[_controller.selectedIndex] == e ? AppStyles.c3C496CW400S14 : AppStyles.c656262W200S14,
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          )),
      appBar: AppWidgets.appBar(AppConst.titleList[_controller.selectedIndex],
          leading: GestureDetector(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: AppColors.kTextFieldInput,
            ),
          )),
      drawer: AppWidgets.drawer((i) {
        _scaffoldkey.currentState!.closeDrawer();
        _controller.changeIndex(i);
        controller.animateToPage(i, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        // controller=PageController(initialPage: value);
      }),
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: const [
          Home(),
          Portfolio(),
          Market(),
          Proposals(),
          Profile(),
        ],
        onPageChanged: (page) {},
      ),
    );
  }
}
