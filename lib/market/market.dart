import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kleber_bank/market/market_controller.dart';
import 'package:kleber_bank/market/my_video_widget.dart';
import 'package:kleber_bank/market/video_player_widget.dart';
import 'package:kleber_bank/utils/app_colors.dart';
import 'package:kleber_bank/utils/common_functions.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';
import 'add_transaction.dart';
import 'market_list_model.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  Timer? _debounce;
  late MarketController _notifier;

  int pageKey = 1;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<MarketController>(context, listen: false).pagingController.addPageRequestListener((pageKey) {
      _fetchPageActivity();
    });
    super.initState();
  }

  Future<void> _fetchPageActivity() async {
    MarketController provider = Provider.of<MarketController>(context, listen: false);
    await provider.getList(pageKey);
    final isLastPage = provider.marketList.length < 10;
    if (isLastPage) {
      provider.pagingController.appendLastPage(provider.marketList);
    } else {
      pageKey++;
      provider.pagingController.appendPage(provider.marketList, pageKey);
    }
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
                            pageKey=1;
                            _notifier.refresh();
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
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  pageKey = 1;
                  _notifier.pagingController.refresh();
                },
                child: PagedListView<int, MarketListModel>(
                  pagingController: _notifier.pagingController,
                  // shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: rSize * 0.015),
                  builderDelegate: PagedChildBuilderDelegate<MarketListModel>(noItemsFoundIndicatorBuilder: (context) {
                    return const SizedBox();
                  }, itemBuilder: (context, item, index) {
                    return GestureDetector(
                      onTap: () {
                        CommonFunctions.navigate(
                            context,
                            VideoPlayerItem(
                              item.videoUrl ?? '',
                              // onPlayStatusChanged: (bool) {},
                            ));
                      },
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Change this value for different corner radii
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: double.infinity,
                              height: rSize * 0.25,
                              decoration: BoxDecoration(color: AppColors.kHint, borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.center,
                              child: displayFile(item, index),
                            ),
                            Padding(
                              padding: EdgeInsets.all(rSize * 0.015),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.assetClassName ?? '',
                                    style: AppStyles.c3C496CW500S16,
                                  ),
                                  Text(
                                    item.name ?? '',
                                    style: AppStyles.c656262W200S14.copyWith(fontSize: AppStyles.px12),
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: rSize * 0.015,
                                  ),
                                  GestureDetector(
                                      onTap: ()=>CommonFunctions.navigate(context,AddTransaction()),
                                      child: AppWidgets.btn('Add Transaction'))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? displayFile(MarketListModel item, int index) {
    if (item.imageUrl == null && item.videoUrl == null) {
      return null;
    } else if (item.imageUrl != null) {
      return Image.network(
        item.imageUrl ?? '',
        fit: BoxFit.fitHeight,
        // width: double.infinity,
        // height: double.infinity,
      );
    } else {
      // return MainPage(item.videoUrl??'');
      return SizedBox(
        height: 150,
        child: VideoPlayerItem(
          item.videoUrl??'',
          /*onPlayStatusChanged: (isPlaying) {
            _notifier.onPlayStatusChanged(index, isPlaying);
          },*/
        ),
      );
    }
  }

  void openFilterDialog() {
    _notifier.getFilterDropDown();
    MarketListModel? selectedAssetClass, selectedIndustry, selectedCurrency;
    selectedAssetClass = _notifier.selectedAssetClass;
    selectedIndustry = _notifier.selectedIndustry;
    selectedCurrency = _notifier.selectedCurrency;
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            _notifier = Provider.of<MarketController>(context);
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
                    DropdownSearch<MarketListModel>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: _notifier.assetClassList,
                      itemAsString: (item) => item.name ?? '',
                      filterFn: (item, filter) => CommonFunctions.compare(filter, item.name ?? ''),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Asset Class')),
                      ),
                      onChanged: (value) {
                      selectedAssetClass=value;
                      },
                      selectedItem: selectedAssetClass,
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    DropdownSearch<MarketListModel>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: _notifier.industryList,
                      itemAsString: (item) => item.name ?? '',
                      filterFn: (item, filter) => CommonFunctions.compare(filter, item.name ?? ''),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Industry')),
                      ),
                      onChanged: (value) {
                        selectedIndustry=value;
                      },
                      selectedItem: selectedIndustry,
                    ),
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    DropdownSearch<MarketListModel>(
                      popupProps: PopupProps.menu(
                        // showSelectedItems: true,
                        showSearchBox: true,
                        searchDelay: Duration.zero,
                      ),
                      items: _notifier.currencyList,
                      itemAsString: (item) => item.name ?? '',
                      filterFn: (item, filter) => CommonFunctions.compare(filter, item.name ?? ''),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: AppStyles.dropDownInputDecoration(AppWidgets.textFieldLabel('Currency')),
                      ),
                      onChanged: (value) {
                        selectedCurrency = value;
                      },
                      selectedItem: selectedCurrency,
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
                          child: InkWell(onTap: () async {
                            _notifier.selectedAssetClass=null;
                            _notifier.selectedCurrency=null;
                            _notifier.selectedIndustry=null;
                            pageKey=1;
                            _notifier.refresh();
                            Navigator.pop(context);
                          }, child: AppWidgets.btn('CLEAR', borderOnly: true)),
                        ),
                        SizedBox(
                          width: rSize * 0.02,
                        ),
                        Expanded(
                          child: InkWell(onTap: () async {
                            _notifier.selectedAssetClass=selectedAssetClass;
                            _notifier.selectedCurrency=selectedCurrency;
                            _notifier.selectedIndustry=selectedIndustry;
                            pageKey=1;
                            _notifier.refresh();
                            Navigator.pop(context);
                          }, child: AppWidgets.btn('APPLY')),
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
