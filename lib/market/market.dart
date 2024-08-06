import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kleber_bank/market/market_controller.dart';
import 'package:kleber_bank/utils/app_colors.dart';
import 'package:kleber_bank/utils/common_functions.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';
import 'add_transaction.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  Timer? _debounce;
  late MarketController _notifier;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<MarketController>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: rSize * 0.015),
        child: Column(
          // padding: EdgeInsets.symmetric(horizontal: rSize*0.015,vertical: rSize*0.01),
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                      elevation: 2,
                      color: Colors.white,
                      child: TextField(
                        controller: _notifier.searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: AppStyles.c929292W500S14,
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search),
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10)),
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce = Timer(const Duration(milliseconds: 500), () async {
                            // pageKey = 1;
                            // _pagingController.refresh();
                          });
                        },
                      )),
                ),
                Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.kViolate,
                ),
                GestureDetector(
                    onTap: () => openFilterDialog(),
                    child: Text(
                      'Filter',
                      style: AppStyles.c3C496CW500S18,
                    ))
              ],
            ),
            SizedBox(
              height: rSize * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: rSize * 0.015,
                    ),
                    height: rSize * 0.3,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: double.infinity,
                            height: rSize * 0.25,
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/login_bg.jpg',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: rSize * 0.4,
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: rSize * 0.02, vertical: 2),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(rSize * 0.015),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Other',
                                          style: AppStyles.c3C496CW500S16,
                                        ),
                                        GestureDetector(
                                          onTap: () => CommonFunctions.navigate(context,AddTransaction()),
                                          child: Text(
                                            'Add Transaction',
                                            style: AppStyles.c3C496CW500S16
                                                .copyWith(color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: rSize * 0.01,
                                    ),
                                    Text(
                                      'The 2011 London riots prepared Sta rmer for stopping unrest but tackling',
                                      style: AppStyles.c656262W200S14.copyWith(fontSize: AppStyles.px12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
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
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: ["All", "Class 1", "Class 2", 'Class 3'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Asset Class')),
                      ),
                      onChanged: print,
                      selectedItem: "All",
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: ["All", "Ind 1", "Ind 2", 'Ind 3'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Industry')),
                      ),
                      onChanged: print,
                      selectedItem: "All",
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: ["All", "USDINR", "USDJPY", 'GBPUSD'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Currency')),
                      ),
                      onChanged: print,
                      selectedItem: "All",
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
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
}
