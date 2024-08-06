import 'package:flutter/material.dart';
import 'package:kleber_bank/proposals/proposal_controller.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';

class Proposals extends StatefulWidget {
  const Proposals({super.key});

  @override
  State<Proposals> createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  late ProposalController _notifier;

  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<ProposalController>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rSize * 0.05, vertical: rSize * 0.01),
            child: Row(
              children: [
                cell(
                  'filter.png',
                  '  FILTER',
                  () {
                    openFilterDialog();
                  },
                ),
                SizedBox(
                  width: rSize * 0.03,
                ),
                cell(
                  'sort.png',
                  '  SORT',
                  () {
                    openSortBottomSheet();
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: rSize * 0.015),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: rSize * 0.005),
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(rSize * 0.015),
                    children: [
                      GestureDetector(
                        onTap: () => _notifier.selectTransactionIndex(index),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '280-Proposal',
                                  style: AppStyles.c656262W500S16,
                                )),
                                SizedBox(
                                  width: rSize * 0.015,
                                ),
                                RotatedBox(
                                    quarterTurns: _notifier.selectedIndex == index ? 1 : 3,
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: AppColors.kTextFieldInput,
                                      size: 15,
                                    )),
                              ],
                            ),
                            if (_notifier.selectedIndex == index) ...{
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
                                          AppWidgets.portfolioListElement('mof mof', 'Sell to Open'),
                                          SizedBox(
                                            height: rSize * 0.005,
                                          ),
                                          AppWidgets.portfolioListElement('Last Update', '2024-07-26 14:14'),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          AppWidgets.btn('Read Proposal'),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: false,
                                                onChanged: (value) {},
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'I read the document and agree to the terms of proposal',
                                                  style: AppStyles.c656262W500S14,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: rSize * 0.02,
                                              ),
                                              Expanded(
                                                  child: AppWidgets.btnWithIcon(
                                                      '  Decline',
                                                      Colors.red,
                                                      Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ))),
                                              SizedBox(
                                                width: rSize * 0.02,
                                              ),
                                              Expanded(
                                                  child: AppWidgets.btnWithIcon(
                                                      '  Accept',
                                                      Colors.green,
                                                      Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ))),
                                              SizedBox(
                                                width: rSize * 0.02,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: rSize * 0.025,
                                          ),
                                          proposalElement('   Call your Advisor', Icons.call),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          AppWidgets.divider(),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          proposalElement('   Chat with your Advisor', Icons.chat_outlined),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          AppWidgets.divider(),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          proposalElement('   Schedule Appointment', Icons.calendar_month),
                                          SizedBox(
                                            height: rSize * 0.01,
                                          ),
                                          AppWidgets.divider(),
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
              },
            ),
          )
        ],
      ),
    );
  }

void openFilterDialog() {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    left: rSize * 0.02, right: rSize * 0.02, top: rSize * 0.03, bottom: MediaQuery.of(context).viewInsets.bottom + rSize * 0.03),
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            'Filter',
                            style: AppStyles.c3C496CW500S18.copyWith(fontSize: AppStyles.px22),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.kTextFieldInput,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: rSize * 0.02,
                  ),
                  TextFormField(
                    onChanged: (value) {
                    },
                    decoration: AppStyles.inputDecoration(label: 'Advisor'),
                  ),
                  SizedBox(
                    height: rSize * 0.02,
                  ),
                  TextFormField(
                    onChanged: (value) {
                    },
                    decoration: AppStyles.inputDecoration(label: 'Proposal Name'),
                  ),
                  SizedBox(
                    height: rSize * 0.02,
                  ),
                  DropdownButtonFormField(
                      decoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Types')),
                      isExpanded: true,
                      icon: AppWidgets.dropDownIcon(),
                      style: AppStyles.c3C496CW500S18,
                      isDense: true,
                      value: 'All',
                      onChanged: (value) {
                        setState((){});
                      },
                      items: _notifier.typesList
                          .map(
                            (String item) => DropdownMenuItem<String>(value: item, child: AppWidgets.dropDownHint(item)),
                      )
                          .toList(),
                      hint: AppWidgets.dropDownHint('Select Types')),
                  SizedBox(
                    height: rSize * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(onTap: () async {}, child: AppWidgets.btn('CLEAR', borderOnly: true)),
                      ),
                      SizedBox(
                        width: rSize * 0.02,
                      ),
                      Expanded(
                        child: InkWell(onTap: () async {}, child: AppWidgets.btn('APPLY')),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      );
    },
  );
}

  void openSortBottomSheet() {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: rSize * 0.015),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Text(
                        'SORT',
                        style: AppStyles.c656262W500S20,
                      ),
                      Container(
                        height: 0.5,
                        margin: EdgeInsets.symmetric(vertical: rSize * 0.0075),
                        width: double.infinity,
                        color: AppColors.kHint,
                      ),
                      sortDialogElement(0, 'Newest'),
                      sortDialogElement(1, 'Oldest'),
                      sortDialogElement(2, 'A-Z'),
                      sortDialogElement(3, 'Z-A'),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Row sortDialogElement(int value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: '',
          onChanged: (p0) {
            Navigator.pop(context);
          },
        ),
        Expanded(
            child: Text(
              label,
              style: AppStyles.c656262W500S18,
            )),
      ],
    );
  }

  Widget proposalElement(String title, IconData iconData) {
    return Row(
      children: [
        Icon(
          iconData,
          color: AppColors.kTextFieldInput,
          size: 20,
        ),
        Expanded(
            child: Text(
          title,
          style: AppStyles.c656262W400S16,
        )),
        const RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.kTextFieldInput,
              size: 15,
            ))
      ],
    );
  }

  Expanded cell(String img, String label, void Function()? onTap) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(rSize * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.kTextFieldInput, width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/$img',
              color: AppColors.kTextFieldInput,
              scale: 25,
            ),
            Text(
              label,
              style: AppStyles.c656262W500S14,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }
}
