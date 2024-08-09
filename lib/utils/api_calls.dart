import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kleber_bank/login/user_info_model.dart';
import 'package:kleber_bank/market/market_list_model.dart';
import 'package:kleber_bank/portfolio/portfolio_model.dart';
import 'package:kleber_bank/portfolio/position_model.dart';
import 'package:kleber_bank/portfolio/transaction_model.dart';
import 'package:kleber_bank/portfolio/transactions.dart';
import 'package:kleber_bank/utils/shared_pref_utils.dart';
import '../documents/document_model.dart';
import '../proposals/proposal_model.dart';
import 'app_const.dart';
import 'common_functions.dart';
import 'end_points.dart';

class ApiCalls {
  static Future<bool> login(String email, String pwd) async {
    try {
      var url = Uri.parse(
        EndPoints.login,
      );

      var response = await http.post(url, body: {'email': email, 'password': pwd});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("token")) {
        SharedPrefUtils.instance.putString(TOKEN, json['token']!);
        return true;
      } else {
        CommonFunctions.showToast(json['errors']!);
      }
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('add cust error ${e.toString()}::: ${e.stackTrace}');
    }
    return false;
  }

  static Future<UserInfotModel?> getUserInfo() async {
    try {
      var url = Uri.parse(
        EndPoints.userInfo,
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      UserInfotModel model = UserInfotModel.fromJson(json);
      AppConst.userModel = model;
      return model;
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<ProposalModel?> updateProposalState(int id, String state) async {
    try {
      var url = Uri.parse(
        '${EndPoints.proposals}/$id/update_state?state=$state',
      );

      var response = await http.put(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      return ProposalModel.fromJson(json);
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> sendOtp() async {
    try {
      var url = Uri.parse(
        EndPoints.sendOtp,
      );

      var response = await http.post(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> verifyOtp(String code, String verificationCode) async {
    try {
      var url = Uri.parse(
        '${EndPoints.verifyOtp}?code=$code&verification_code=$verificationCode',
      );

      var response = await http.post(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getTermOfService() async {
    try {
      var url = Uri.parse(
        EndPoints.termOfService,
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> acceptanceTermsOfService() async {
    try {
      var url = Uri.parse(
        EndPoints.acceptanceTermsOfService,
      );

      var response = await http.post(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }

  static Future<List<MarketListModel>> getMarketList(
    int pageKey,
    String searchedWord,
    String selectedClass,
    String selectedIndustry,
    String selectedCurrency,
  ) async {
    try {
      Map<String, dynamic> params = {
        'page': pageKey.toString(),
        'filter[currency_name]': selectedCurrency,
        'filter[name]': searchedWord,
        'filter[asset_class]': selectedClass,
        'filter[industry]': selectedIndustry,
      };
      params.removeWhere(
        (key, value) => value == null || value.toString().isEmpty,
      );
      var url = Uri.https(EndPoints.baseUrl.replaceAll('/client_portal_api/', '').replaceAll('https://', ''), '/client_portal_api/markets', params);

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url $params");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => MarketListModel.fromJson(jsonItem)).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<PortfolioModel>> getPortfolioList(int pageKey) async {
    try {
      var url = Uri.parse(
        EndPoints.portfolios,
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => PortfolioModel.fromJson(jsonItem)).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<PositionModel>> getPositionList(int pageKey, int portfolioId, String column, String direction) async {
    try {
      Map<String, dynamic> params = {
        'page': pageKey.toString(),
        'order[column]': column,
        'order[direction]': direction,
      };
      print("params $params");
      var url = Uri.https(EndPoints.baseUrl.replaceAll('/client_portal_api/', '').replaceAll('https://', ''),
          '/client_portal_api/portfolios/$portfolioId/portfolio_securities', params);

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => PositionModel.fromJson(jsonItem)).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<TransactionModel>> getTransactionList(int pageKey, String name) async {
    try {
      var url = Uri.parse(
        '${EndPoints.transactions}?page=$pageKey&filter[portfolio_name]=$name',
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => TransactionModel.fromJson(jsonItem)).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<ProposalModel>> getProposalList(
      int pageKey, String proposalName, String advisorName, String? selectedProposalType, String column, String direction) async {
    try {
      Map<String, dynamic> params = {
        'order[column]': column,
        'order[direction]': direction,
        'filter[name]': proposalName,
        'filter[advisor]': advisorName,
        'filter[proposal_type]': selectedProposalType,
        'page': pageKey.toString(),
      };

      print('params $params');

      params.removeWhere(
        (key, value) => value == null || value.toString().isEmpty,
      );
      params.removeWhere(
        (key, value) => value == null || value.toString().isEmpty,
      );
      var url = Uri.https(EndPoints.baseUrl.replaceAll('/client_portal_api/', '').replaceAll('https://', ''), '/client_portal_api/proposals', params);

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => ProposalModel.fromJson(jsonItem)).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<String>> getProposalTypeList() async {
    try {
      var url = Uri.parse(
        EndPoints.proposalTypes,
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => jsonItem.toString()).toList();
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<List<MarketListModel>> getMarketFilterDropDownData(String endPoint) async {
    try {
      var url = Uri.parse(
        endPoint,
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");
      List<dynamic> json = jsonDecode(response.body);

      return json.map((jsonItem) => MarketListModel.fromJson(jsonItem)).toList();
    } catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      // print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return [];
  }

  static Future<DocumentModel?> getDocumentList(int page) async {
    try {
      var url = Uri.parse(
        '${EndPoints.documents}?page=$page',
      );

      var response = await http.get(url, headers: {'Authorization': 'Bearer ${SharedPrefUtils.instance.getString(TOKEN)}'});
      print("url $url");
      print("response ${response.body}");

      return DocumentModel.fromJson(jsonDecode(response.body));
    } on SocketException catch (e) {
      CommonFunctions.showToast(AppConst.connectionError);
    } on TimeoutException catch (e) {
      CommonFunctions.showToast(AppConst.connectionTimeOut);
    } on Error catch (e) {
      CommonFunctions.showToast(AppConst.somethingWentWrong);
      print('user info API error ${e.toString()}::: ${e.stackTrace}');
    }
    return null;
  }
}
