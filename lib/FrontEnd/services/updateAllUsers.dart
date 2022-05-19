import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateUsers {
  Dio dio = new Dio();

  updatePatient(type, email, password) async {
    try {
      return await dio.put(
        'https://nitc-tele-health-app.herokuapp.com/forgotuser/$email',
        data: {
          "type": type,
          "email": email,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  updateAdmin(type, email, password) async {
    try {
      return await dio.put(
        'https://nitc-tele-health-app.herokuapp.com/forgotadmin/$email',
        data: {
          "type": type,
          "email": email,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  updateDoc(type, email, password) async {
    try {
      return await dio.put(
        'https://nitc-tele-health-app.herokuapp.com/forgotdoc/$email',
        data: {
          "type": type,
          "email": email,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
