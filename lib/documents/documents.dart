import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kleber_bank/documents/documents_controller.dart';
import 'package:kleber_bank/documents/upload_document.dart';
import 'package:kleber_bank/utils/app_widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/common_functions.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  late DocumentsController _notifier;

  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<DocumentsController>(context);
    return Scaffold(
      appBar: AppWidgets.appBar('Documents'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          CommonFunctions.navigate(context, UploadDocument());
        },
        child: Icon(Icons.add),
      ),
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
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: rSize * 0.015),
              color: Colors.white,
              child: ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                padding: EdgeInsets.all(rSize * 0.015),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.kHint, width: 0.3))),
                    padding: EdgeInsets.symmetric(vertical: rSize * 0.01),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.all(rSize * 0.01),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: AppColors.kTextFieldInput, width: 0.2)),
                          child: Image.asset(
                            'assets/doc.png',
                            color: AppColors.kTextFieldInput,
                            scale: 30,
                          )),
                      SizedBox(
                        width: rSize * 0.01,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '250165 CRS Status Declaration Form for Account Holder ssss dddddd ',
                            style: AppStyles.c656262W500S16,
                            maxLines: 2,
                          ),
                          Text(
                            '2024-07-31 10:55',
                            style: AppStyles.c656262W200S14,
                            maxLines: 2,
                          ),
                          if (index == 3) ...{
                            Text(
                              'Accepted at 2024-07-31 10:55',
                              style: AppStyles.c656262W400S16.copyWith(color: Colors.green),
                              maxLines: 2,
                            )
                          },
                          if (index == 5) ...{
                            Text(
                              'Rejected at 2024-07-31 10:55',
                              style: AppStyles.c656262W400S16.copyWith(color: Colors.red),
                              maxLines: 2,
                            )
                          },
                        ],
                      )),
                      popupMenu(),
                      /*const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.kTextFieldInput,
                            size: 15,
                          ))*/
                    ]),
                  );
                },
              ),
            ),
          )
        ],
      ),
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

  void openFilterDialog() {
    String _searchedFileName = _notifier.searchedFile;
    String? _selectedType = _notifier.selectedType;
    String _selecteStartDate = _notifier.startDate;
    String _selecteEndDate = _notifier.endDate;
    String _range = _notifier.range;
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
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchDelay: Duration.zero,
                          constraints: BoxConstraints(maxHeight: rSize * 0.3)),
                      items: ["All", 'Account 1', 'Account 2'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Type')),
                      ),
                      onChanged: print,
                      selectedItem: "All",
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    TextFormField(
                      decoration: AppStyles.inputDecoration(label: 'File Name'),
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    DropdownButtonFormField(
                        decoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Types')),
                        isExpanded: true,
                        icon: AppWidgets.dropDownIcon(),
                        style: AppStyles.c3C496CW500S18,
                        isDense: true,
                        value: 'All',
                        onChanged: (value) {
                          setState(() {});
                        },
                        items: _notifier.typesList
                            .map(
                              (String item) => DropdownMenuItem<String>(value: item, child: AppWidgets.dropDownHint(item)),
                            )
                            .toList(),
                        hint: AppWidgets.dropDownHint('Select Types')),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: _range),
                      onTap: () async {
                        AppWidgets.openDatePicker(
                          context,
                          (value) {
                            if (value is PickerDateRange) {
                              final String startDate = CommonFunctions.getYYYYMMDD(value.startDate!);
                              final String endDate = CommonFunctions.getYYYYMMDD(value.endDate!);
                              _range = '$startDate  TO  $endDate';
                              if (_range.isNotEmpty) {
                                _selecteStartDate = _range.split('  TO  ')[0];
                                _selecteEndDate = _range.split('  TO  ')[1];
                              } else {
                                _range = '';
                                _selecteStartDate = '';
                                _selecteEndDate = '';
                              }
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          () {
                            _notifier.setDate('');
                            Navigator.pop(context);
                            setState(() {});
                          },
                        );
                      },
                      decoration: AppStyles.inputDecoration(label: 'From-To Date'),
                    ),
                    SizedBox(
                      height: rSize * 0.02,
                    ),
                    SizedBox(
                      height: rSize * 0.03,
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
                          child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: AppWidgets.btn('APPLY')),
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
          groupValue: _notifier.sortRadioGroupValue,
          onChanged: (p0) {
            // pageKey = 1;
            _notifier.setSortRadioGroupValue(value, label);
            // _pagingController.refresh();
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

  popupMenu() {
    return PopupMenuButton<int>(
      child: Icon(Icons.more_vert),
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        popupMenuItem(1,'View',Icons.remove_red_eye,(){}),
        popupMenuItem(2,'Download',Icons.download,(){}),
        popupMenuItem(3,'Signature',Icons.edit,(){
          AppWidgets.showAlert(context, 'Please Confirm your action', 'Reject', 'Accept', () {

          }, () {

          },);
        }),
      ],
      offset: Offset(0, 0),
      color: Colors.grey,
      elevation: 2,
    );
  }

  PopupMenuItem<int> popupMenuItem(int value,String label, IconData iconData, void Function()? onTap) {
    return PopupMenuItem(
        value: value,onTap:onTap ,
        // row has two child icon and text.
        child: Row(
          children: [
            Icon(iconData),
            SizedBox(
              // sized box with width 10
              width: 10,
            ),
            Text(label)
          ],
        ),
      );
  }
}
