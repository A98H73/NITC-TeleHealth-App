import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewUser {
  Dio dio = new Dio();

  AddUser(name, type, branch, rollno, email, password) async {
    try {
      return await dio.post(
        'https://nitc-tele-health-app.herokuapp.com/adduser',
        data: {
          "name": name,
          "type": type,
          "branch": branch,
          "rollno": rollno,
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

  AddAdmin(name, type, college_id, phone, email, password) async {
    try {
      return await dio.post(
        'https://nitc-tele-health-app.herokuapp.com/addadmin',
        data: {
          "name": name,
          "type": type,
          "college_id": college_id,
          "phone": phone,
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

  AddDoc(name, type, college_id, spec_in, email, password) async {
    try {
      return await dio.post(
        'https://nitc-tele-health-app.herokuapp.com/adddoc',
        data: {
          "name": name,
          "type": type,
          "college_id": college_id,
          "spec_in": spec_in,
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
