import 'dart:convert';

import 'package:demo/controller/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController {
  // RxBool loading = false.obs;
  TextEditingController designation = TextEditingController();
  StorageController _storageController = new StorageController();

  _apiRequest(String url, Map<String, dynamic> params,
      Map<String, dynamic>? headers) async {
    final dio = Dio();
    var response = await dio.post(url,
        queryParameters: params, options: Options(headers: headers));
    print(response);
    if (response.statusCode == 200) {
      print("++++++++++++++++++++");
      print(response.data);
      print("++++++++++++++++++++");
      Map<String, dynamic> data = jsonDecode(response.data);
      return data;
    }
    return null;
  }

  sendOTP(phone) async {
    String url = "https://test-otp-api.7474224.xyz/sendotp.php";
    Map<String, dynamic> data = {"mobile": phone};
    var res = await _apiRequest(url, data, null);
    // convert res from json to map

    if (res != null) {
      // res = res as Map<String, dynamic>;
      if (res["status"]) {
        print("OTP sent successfully");
        return res["request_id"];
      }
    }
    return null;
  }

  verifyOTP(String reqID, String value) async {
    String url = "https://test-otp-api.7474224.xyz/verifyotp.php";
    Map<String, dynamic> data = {"request_id": reqID, "code": value};
    var res = await _apiRequest(url, data, null);
    if (res != null) {
      if (res['status']) {
        print("OTP verified successfully");
        StorageController().addForAuth(res['jwt']);
      }
      return res;
    }
    return null;
  }
  addData(String jwt,String name,String email )async{
    String url = "https://test-otp-api.7474224.xyz/profilesubmit.php";
    Map<String, dynamic> data = {"name": name, "email": email};
    var res = await _apiRequest(url, data, {
      "Token" : jwt
    });
    if (res != null) {
      if (res['status']) {
        print("Data Added successfully");
      }
      return res;
    }
    return null;
  }
  
  void logout() {
    _storageController.deleteAuth();
    // auth.signOut();
    // Get.offAll(const MyPhone());
  }
}



// Use these values to test:
// Mobile number with profile: 8888888888, valid otp: 000000
// Mobile nuber without profile: 9090909090, valid otp: 123456
 
// URL : https://test-otp-api.7474224.xyz/sendotp.php
 
// Sample Request
// {"mobile" : "8888888888"}
 
// Sample Response
// {
// "status": true,
// "response": "OTP sent successfully.",
// "request_id": "0987654321"
// }
 
// URL: http://localhost/sample-api-login/verifyotp.php
 
// Sample Request
// {
//  "request_id" : "0987654321",
//  "code" : "123456"
// }
 
// Sample Response
// {
// "status": true,
// "profile_exists": false,
// "jwt": "jwt1235"
// }
 
// URL : https://test-otp-api.7474224.xyz/profilesubmit.php
// Headers : 
// Token: jwt1235
 
// Sample Request
// {
//  "name" : "name something",
//  "email" : "123456@h.com"
// }
 
// Sample Response
// {
// "status": true,
// "response": "Profile Submit Success."
// }