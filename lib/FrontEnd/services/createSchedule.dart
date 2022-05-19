import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Schedule {
  Dio dio = new Dio();

  newSchedule(doc_email, doc_name, doc_spec_in, slot, _setDate, _setStartTime,
      _setEndTime) async {
    try {
      return await dio.post(
          'https://nitc-tele-health-app.herokuapp.com/addschedule',
          data: {
            "doc_email": doc_email,
            "doc_name": doc_name,
            "doc_spec_in": doc_spec_in,
            "slot": slot,
            "date": _setDate,
            "start_time": _setStartTime,
            "end_time": _setEndTime,
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
