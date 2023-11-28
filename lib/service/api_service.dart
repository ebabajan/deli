import 'dart:convert';

import 'package:delidove_api/models/customer.dart';
import 'package:delidove_api/config.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class APIService {
  void _bypassSslVerificationForHttpClient() {
    HttpOverrides.global = _MyHttpOverrides();
  }

  createCustomer(CustomerModel model) async {
    _bypassSslVerificationForHttpClient();
    bool created = false;
    var token = Config.token;
    var dio = Dio();
    final url = Config.url + Config.customer;

    var data = model.toJson();

    var headers = {
      'Authorization': 'Basic $token',
    };

    var response = await dio.request(
      url,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(jsonEncode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
