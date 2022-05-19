import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MedicalLeaveReq {
  Dio dio = new Dio();

  AddMedLeave(
      doc_email,
      doc_name,
      doc_spec_in,
      user_name,
      user_email,
      user_rollno,
      user_branch,
      issue_face,
      doc_isaccepted,
      admin_isaccepted) async {
    try {
      return await dio.post(
        'https://nitc-tele-health-app.herokuapp.com/medleave',
        data: {
          "doc_name": doc_name,
          "doc_email": doc_email,
          "doc_spec_in": doc_spec_in,
          "user_name": user_name,
          "user_email": user_email,
          "user_branch": user_branch,
          "user_rollno": user_rollno,
          "issue_face": issue_face,
          "doc_isaccepted": doc_isaccepted,
          "admin_isaccepted": admin_isaccepted
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

  updateMedRequest(
      _id,
      doc_name,
      doc_email,
      doc_spec_in,
      user_name,
      user_email,
      user_rollno,
      user_branch,
      issue_face,
      doc_isaccepted,
      admin_isaccepted) async {
    try {
      return await dio.put(
        'https://nitc-tele-health-app.herokuapp.com/updatemedrequest/$_id',
        data: {
          "doc_name": doc_name,
          "doc_email": doc_email,
          "doc_spec_in": doc_spec_in,
          "user_name": user_name,
          "user_email": user_email,
          "user_branch": user_branch,
          "user_rollno": user_rollno,
          "issue_face": issue_face,
          "doc_isaccepted": doc_isaccepted,
          "admin_isaccepted": admin_isaccepted
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

  removeMedRequest(_id) async {
    try {
      final response = await dio.delete(
          'https://nitc-tele-health-app.herokuapp.com/removemedrequest/$_id');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to delete Data');
      }
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
