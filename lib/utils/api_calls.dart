import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
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
        // SharedPrefUtils.instance.putString(TOKEN, json['access_token']!);
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


}
