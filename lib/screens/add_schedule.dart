import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/Models/schedule.dart';
import 'package:college/components/cookbooks/show_snack_bar.dart';
import 'package:college/components/cookbooks/spinner.dart';
import 'package:college/enums/hall_enum.dart';
import 'package:college/components/custom_buttons/rounded_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../constants.dart';
import 'hall_schedule.dart';

class AddSchedule extends StatefulWidget {
  static const String id = 'add_schedule';

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? doctor, subject;
  Hall? selectedHall;
  DateTime? date, initDate;
  TimeOfDay? startTime, endTime, initStartTime, initEndTime;

  @override
  void initState() {
    super.initState();
    initDate = DateTime.now();
    initStartTime = initEndTime = TimeOfDay.now();
  }

  Future addSchedule(BuildContext context) async {
    var formData = _formKey.currentState;
    if (formData!.validate()) {
      showSpinner(context);
      formData.save();
      Schedule schedule = Schedule(
        subject: subject,
        doctor: doctor,
        hall: selectedHall,
        date: Timestamp.fromDate(date!),
        startTime: startTime?.format(context),
        endTime: endTime?.format(context),
      );
      await schedule.add();
      successSnackBar(context, 'Schedule has been added successfully.');
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HallSchedule.id, arguments: selectedHall);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Schedule", style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          Image(image: AssetImage('images/college.jpg'), height: 170),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Doctor', style: kFormFieldLabel),
                SizedBox(height: 5),
                TextFormField(
                  decoration: kAddScheduleFormFiledDecoration.copyWith(
                    hintText: 'Doctor Name',
                    suffixIcon: Icon(Icons.person_outline, size: 25, color: Colors.blueAccent),
                    contentPadding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  ),
                  validator: (value) => value!.isEmpty ? 'Doctor name is required.' : null,
                  onSaved: (value) => doctor = value!,
                ),
                SizedBox(height: 20),
                // =======================================================================================
                Text('Subject', style: kFormFieldLabel),
                SizedBox(height: 5),
                TextFormField(
                  decoration: kAddScheduleFormFiledDecoration.copyWith(
                    hintText: "Enter Subject",
                    suffixIcon: Icon(Icons.library_books_outlined, size: 23, color: Colors.blueAccent),
                    contentPadding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter subject name.' : null,
                  onSaved: (value) => subject = value!,
                ),
                SizedBox(height: 20),
                // =======================================================================================
                Text('Hall', style: kFormFieldLabel),
                SizedBox(height: 5),
                DropdownButtonFormField2(
                  decoration: kAddScheduleFormFiledDecoration.copyWith(),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  items: halls.map<DropdownMenuItem<Hall>>((Hall hall) {
                    return DropdownMenuItem<Hall>(
                      value: hall,
                      child: Text(getHallName(hall), style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  onChanged: (newValue) {},
                  validator: (value) => value == null ? 'Please select the hall.' : null,
                  onSaved: (value) => selectedHall = value as Hall?,
                ),
                // =======================================================================================
                Divider(color: Colors.grey, height: 50),
                // =======================================================================================
                Text('Date', style: kFormFieldLabel),
                SizedBox(height: 5),
                TextFormField(
                  readOnly: true,
                  decoration: kAddScheduleFormFiledDecoration.copyWith(
                    hintText: date != null ? Jiffy(date).format('dd/MM/yyyy') : "schedule date",
                    suffixIcon: Icon(Icons.calendar_today, size: 23, color: Colors.blueAccent),
                    contentPadding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  ),
                  validator: (value) => date == null ? 'Select schedule date.' : null,
                  onTap: () async {
                    date = await showDatePicker(
                        context: context,
                        initialDate: initDate as DateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                        builder: (context, child) {
                          return Theme(data: ThemeData(), child: child as Widget);
                        });
                    if (date != null && date != initDate) {
                      setState(() {
                        initDate = date;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                // =======================================================================================
                Text('Start Time', style: kFormFieldLabel),
                SizedBox(height: 5),
                TextFormField(
                  readOnly: true,
                  decoration: kAddScheduleFormFiledDecoration.copyWith(
                    hintText: startTime != null ? startTime?.format(context) : "add time",
                    hintStyle: startTime != null
                        ? TextStyle(fontSize: 15, color: Colors.blue.shade700)
                        : TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),
                    suffixIcon: Icon(Icons.more_time, size: 23, color: Colors.blueAccent),
                    contentPadding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  ),
                  validator: (value) => startTime == null ? 'Choose schedule start time.' : null,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: initStartTime as TimeOfDay,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                          child: child as Widget,
                        );
                      },
                    );

                    if (pickedTime != null)
                      setState(() {
                        initStartTime = startTime = pickedTime;
                      });
                  },
                ),
                SizedBox(height: 20),
                // =======================================================================================
                Text('End Time', style: kFormFieldLabel),
                SizedBox(height: 5),
                TextFormField(
                  readOnly: true,
                  decoration: kAddScheduleFormFiledDecoration.copyWith(
                    hintText: endTime != null ? endTime?.format(context) : "add time",
                    hintStyle: endTime != null
                        ? TextStyle(fontSize: 15, color: Colors.blue.shade700)
                        : TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),
                    suffixIcon: Icon(Icons.more_time, size: 23, color: Colors.blueAccent),
                    contentPadding: EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  ),
                  validator: (value) => endTime == null ? 'Choose schedule end time.' : null,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: initEndTime as TimeOfDay,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                          child: child as Widget,
                        );
                      },
                    );
                    if (pickedTime != null)
                      setState(() {
                        initEndTime = endTime = pickedTime;
                      });
                  },
                ),
                SizedBox(height: 50),
                // =======================================================================================
                RoundedButton(
                  title: 'Add',
                  colour: Colors.teal,
                  titleStyle: TextStyle(fontSize: 17, color: Colors.white),
                  onPressed: () async => await addSchedule(context),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
