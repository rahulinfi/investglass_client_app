import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kleber_bank/dashboard/dashboard_controller.dart';
import 'package:kleber_bank/login/login.dart';
import 'package:kleber_bank/portfolio/portfolio_controller.dart';
import 'package:kleber_bank/profile/profile_controller.dart';
import 'package:kleber_bank/proposals/proposal_controller.dart';
import 'package:kleber_bank/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'documents/documents_controller.dart';
import 'login/login_controller.dart';
import 'market/market_controller.dart';

double rSize = 0;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),ChangeNotifierProvider(
      create: (context) => DashboardController(),
    ),ChangeNotifierProvider(
      create: (context) => PortfolioController(),
    ),ChangeNotifierProvider(
      create: (context) => ProfileController(),
    ),ChangeNotifierProvider(
      create: (context) => ProposalController(),
    ),ChangeNotifierProvider(
      create: (context) => MarketController(),
    ),ChangeNotifierProvider(
      create: (context) => DocumentsController(),
    ),
  ],child:const MyApp() ,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size ksize = MediaQuery.of(context).size;
    rSize = pow((ksize.height * ksize.height) + (ksize.width * ksize.width), 1 / 2) as double;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bg),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
