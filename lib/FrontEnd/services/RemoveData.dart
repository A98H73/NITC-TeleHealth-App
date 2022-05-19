import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RemoveUser {
  Dio dio = new Dio();

  DeleteUser(email) async {
    try {
      final response = await dio.delete(
          'https://nitc-tele-health-app.herokuapp.com/deleteuser/$email');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to delete Data');
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getData(email) async {
    try {
      return await dio.post(
          'https://nitc-tele-health-app.herokuapp.com/fetchuser/',
          data: {
            "email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

class RemoveAdmin {
  Dio dio = new Dio();

  DeleteAdmin(email) async {
    try {
      final response = await dio.delete(
          'https://nitc-tele-health-app.herokuapp.com/deleteadmin/$email');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to delete Data');
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getAdminData(email) async {
    try {
      return await dio.post(
          'https://nitc-tele-health-app.herokuapp.com/fetchadmin/',
          data: {
            "email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

class RemoveDoc {
  Dio dio = new Dio();

  DeleteDoc(email) async {
    try {
      final response = await dio.delete(
          'https://nitc-tele-health-app.herokuapp.com/deletedoc/$email');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to delete Data');
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getDocData(email) async {
    try {
      return await dio.post(
          'https://nitc-tele-health-app.herokuapp.com/fetchdoc/',
          data: {
            "email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
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



// class Rmdata {
//   bool? success;
//   String? msg;
//   String? name;
//   String? type;
//   String? branch;
//   String? rollno;
//   String? email;

//   Rmdata(
//       {this.success,
//       this.msg,
//       this.name,
//       this.type,
//       this.branch,
//       this.rollno,
//       this.email});

//   factory Rmdata.fromJson(Map<String, dynamic> json) {
//     return Rmdata(
//         success: json['success'],
//         msg: json['msg'],
//         name: json['name'],
//         type: json['type'],
//         branch: json['branch'],
//         rollno: json['rollno'],
//         email: json['email']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['msg'] = this.msg;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['branch'] = this.branch;
//     data['rollno'] = this.rollno;
//     data['email'] = this.email;
//     return data;
//   }
// }
