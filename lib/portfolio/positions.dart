import 'package:flutter/material.dart';
import 'package:kleber_bank/portfolio/portfolio_controller.dart';
import 'package:kleber_bank/utils/app_widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class Positions extends StatefulWidget {
  const Positions({super.key});

  @override
  State<Positions> createState() => _PositionsState();
}

class _PositionsState extends State<Positions> {
  late PortfolioController _notifier;
  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<PortfolioController>(context);
    return Scaffold(
      appBar: AppWidgets.appBar('Positions of 2024-08-02'),
      body: Padding(
        padding: EdgeInsets.all(rSize*0.015),
        child: Column(
          children: [
            DropdownButtonFormField(
                decoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('')),
                isExpanded: true,
                icon: AppWidgets.dropDownIcon(),
                style: AppStyles.c3C496CW500S18,
                isDense: true,
                value: _notifier.selectedPositionFilter,
                onChanged: (value) {
                  _notifier.selectPositionFilter(value!);
                },
                items: _notifier.positionsFilterTypeList
                    .map(
                      (String item) => DropdownMenuItem<String>(value: item, child: AppWidgets.dropDownHint(item)),
                )
                    .toList(),
                hint: AppWidgets.dropDownHint('Select Types')),
            SizedBox(height: rSize*0.015,),
            Flexible(
              child: ListView.builder(
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
                        onTap: () => _notifier.selectPositionIndex(index),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      'CHF',
                                      style: AppStyles.c656262W500S16,
                                    )),
                                SizedBox(
                                  width: rSize * 0.015,
                                ),
                                RotatedBox(
                                    quarterTurns: _notifier.selectedPositionIndex == index ? 1 : 3,
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: AppColors.kTextFieldInput,
                                      size: 15,
                                    )),

                              ],
                            ),
                              if (_notifier.selectedPositionIndex != index) ...{
                                SizedBox(height: rSize*0.005,),
                                AppWidgets.portfolioListElement('Allocation', '100%', middleValue: '100,000,000.00'),
                                AppWidgets.portfolioListElement('ROI', '-')
                              },
                            if (_notifier.selectedPositionIndex == index) ...{
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
                                          AppWidgets.portfolioListElement('Name', 'CHF'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('ISIN', 'CHF'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Currency', 'CHF'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Last Price', '1.00'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Cost Price', '0'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('ROI', '-'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Quality', '100,000,000.00'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('FX Rate', '1.00000'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Amount', '100,000,000.00'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Allocation', '100%'),
                                          SizedBox(
                                            height: rSize * 0.015,
                                          ),
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
            )
          ],
        ),
      ),
    );
  }
}
