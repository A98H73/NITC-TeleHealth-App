import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/createSchedule.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  bool isAPICallProcess = false;
  double? _height;
  double? _width;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? _setStartTime, _setEndTime, _setDate;

  String _hour = "", _minute = "", _time = "";

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedStartTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  String? doc_email;
  String? doc_name;
  String? doc_spec_in;
  String? slot;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Morning"), value: "morning"),
      DropdownMenuItem(child: Text("Afternoon"), value: "afternoon"),
      DropdownMenuItem(child: Text("Evening"), value: "evening"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsSpec {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Mental Health Care"), value: "Mental Health"),
      DropdownMenuItem(
          child: Text("Dental Health Care"), value: "Dental Health"),
      DropdownMenuItem(
          child: Text("Labooratory and diagnostic care"),
          value: "Diagnostic Care"),
      DropdownMenuItem(
          child: Text("Prevensive Care"), value: "Prevensive Care"),
      DropdownMenuItem(
          child: Text("Physical and occupational therapy"),
          value: "Physical therapy"),
      DropdownMenuItem(
          child: Text("Nutritional Care"), value: "Nutritional Care"),
      DropdownMenuItem(child: Text("Mild Problems"), value: "Mild Problems"),
    ];
    return menuItems;
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        _setDate = _dateController.text;
        print("value of: " + _dateController.text);
      });
    return _dateController.text;
  }

  Future<String> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _startTimeController.text = _time;
        _startTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        print("value of start time : " + _startTimeController.text);
        _setStartTime = _startTimeController.text;
      });
    return _startTimeController.text;
  }

  Future<String> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _endTimeController.text = _time;
        _endTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        print("value of end time : " + _endTimeController.text);
        _setEndTime = _endTimeController.text;
      });
    return _endTimeController.text;
  }

  void initState() {
    // _dateController.text = DateFormat.yMd().format(DateTime.now());

    // _startTimeController.text = formatDate(
    //     DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //     [hh, ':', nn, " ", am]).toString();

    // _endTimeController.text = formatDate(
    //     DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //     [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    builder:
    (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Schedule"),
          backgroundColor: HexColor('#283B71'),
        ),
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _ScheduleUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _ScheduleUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/schedule.jpg",
                    width: 245,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 20,
          //     left: 85,
          //     bottom: 30,
          //   ),
          //   child: Text(
          //     "Create Schedule",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 25,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: doc_email),
              onChanged: (value) {
                doc_email = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                } else if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return null;
                } else {
                  return 'Enter Valid Email';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Doctor Email",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: doc_name),
              onChanged: (value) {
                doc_name = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Doctor Name",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: DropdownButtonFormField(
              items: dropdownItemsSpec,
              value: doc_spec_in,
              onChanged: (String? newValue) {
                setState(() {
                  doc_spec_in = newValue!;
                });
              },
              dropdownColor: HexColor('#283B71'),
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelText: "Specilist In",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                //fillColor: Colors.blueAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: DropdownButtonFormField(
              items: dropdownItems,
              value: slot,
              onChanged: (String? newValue) {
                setState(() {
                  slot = newValue!;
                });
              },
              dropdownColor: HexColor('#283B71'),
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelText: "Select Slot",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                //fillColor: Colors.blueAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.red)),
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    onChanged: (value) {
                      _setDate = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Date",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.date_range,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 60,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: (() {
                      _selectStartTime(context);
                    }),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          //_setStartTime = _startTimeController.text;
                        },
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _startTimeController,
                        decoration: InputDecoration(
                            hintText: "Start Time",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: (() {
                      _selectEndTime(context);
                    }),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                        onChanged: (String? value) {
                          //_setEndTime = _endTimeController.text;
                        },
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _endTimeController,
                        decoration: InputDecoration(
                            hintText: "End Time",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                child: Text("SUBMIT"),
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    print(doc_email);
                    print(doc_name);
                    print(doc_spec_in);
                    print(slot);
                    print(_setDate);
                    print(_setStartTime);
                    print(_setEndTime);
                    Schedule()
                        .newSchedule(doc_email, doc_name, doc_spec_in, slot,
                            _setDate, _setStartTime, _setEndTime)
                        .then((val) {
                      print(val.data['success']);
                      if (val.data['success']) {
                        //token = val.data['token'];
                        print(val.data['msg']);
                        Fluttertoast.showToast(
                          msg: 'Schedule is saved successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.pushNamed(context, "/schedule");
                      }
                    });
                  } else {
                    "Something Went Wrong";
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: HexColor("#283B71"),
                    side: BorderSide(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
