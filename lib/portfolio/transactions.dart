import 'package:flutter/material.dart';
import 'package:kleber_bank/portfolio/portfolio_controller.dart';
import 'package:kleber_bank/utils/app_widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late PortfolioController _notifier;
  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<PortfolioController>(context);
    return Scaffold(
      appBar: AppWidgets.appBar('Transactions of 2024-08-02'),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: rSize*0.02,horizontal: rSize*0.015),
        itemCount: 10,
        itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: rSize*0.005),
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(rSize*0.015),
            children: [
              GestureDetector(
                onTap: () => _notifier.selectTransactionIndex(index),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              '1227951',
                              style: AppStyles.c656262W500S16,
                            )),
                        SizedBox(
                          width: rSize * 0.015,
                        ),
                        RotatedBox(
                            quarterTurns: _notifier.selectedTransactionIndex == index ? 1 : 3,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.kTextFieldInput,
                              size: 15,
                            )),

                      ],
                    ),
                      if (_notifier.selectedTransactionIndex != index) ...{
                        SizedBox(height: rSize*0.005,),
                        AppWidgets.portfolioListElement('Security Name', '102343500003 110 Metal account XAU',),
                        AppWidgets.portfolioListElement('Status', 'Pending')
                      },
                    if (_notifier.selectedTransactionIndex == index) ...{
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: rSize * 0.5,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: rSize * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.kViolate.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(rSize * 0.015),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppWidgets.portfolioListElement('Type', 'Sell to Open'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Portfolio Name', 'ALPHA'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Security Name', '102343500003 110 Metal account XAU'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Quantity', '10.00'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Price', 'USD 12.34'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Amount', '123.40'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Trade Date', '2024-07-29 00:00'),
                                  SizedBox(
                                    height: rSize * 0.005,
                                  ),
                                  AppWidgets.portfolioListElement('Status', 'Pending'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
        );
      },),
    );
  }
}
