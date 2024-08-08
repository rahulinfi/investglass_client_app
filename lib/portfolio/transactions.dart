import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kleber_bank/portfolio/portfolio_controller.dart';
import 'package:kleber_bank/portfolio/transaction_model.dart';
import 'package:kleber_bank/utils/app_widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/api_calls.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late PortfolioController _notifier;
  final PagingController<int, TransactionModel> pagingController = PagingController(firstPageKey: 1);
  int pageKey=1;

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPageActivity();
    });
    super.initState();
  }

  Future<void> _fetchPageActivity() async {
    List<TransactionModel> list=await ApiCalls.getTransactionList(pageKey,'GERE PAR LA BANQUE 1');
    final isLastPage = list.length < 10;
    if (isLastPage) {
      pagingController.appendLastPage(list);
    } else {
      pageKey++;
      pagingController.appendPage(list, pageKey);
    }
  }
  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<PortfolioController>(context);
    return Scaffold(
      appBar: AppWidgets.appBar('Transactions of 2024-08-02'),
      body:
      RefreshIndicator(
        onRefresh: () async {
          pageKey = 1;
          pagingController.refresh();
        },
        child: PagedListView<int, TransactionModel>(
          pagingController: pagingController,
          padding: EdgeInsets.all(rSize*0.015),
          // shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate<TransactionModel>(noItemsFoundIndicatorBuilder: (context) {
            return const SizedBox();
          }, itemBuilder: (context, item, index) {
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
                          AppWidgets.portfolioListElement('Security Name', item.portfolioSecurity?.securityName??'',),
                          AppWidgets.portfolioListElement('Status', item.statusView??'')
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
                                      AppWidgets.portfolioListElement('Type', item.transactionType??''),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Portfolio Name', item.portfolioName??''),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Security Name','NEED TO SET'/* item.portfolioSecurity.name*/),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Quantity', item.quantity??''),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Price', 'NEED TO SET'),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Amount', item.amount??''),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Trade Date', item.transactionDatetime??''),
                                      SizedBox(
                                        height: rSize * 0.005,
                                      ),
                                      AppWidgets.portfolioListElement('Status', item.statusView??''),
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
          }),
        ),
      )
    );
  }
}
