import 'package:flutter/material.dart';

final kFromToTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.lightBlue.shade600,
);

final kDoctorSubjectTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.teal.shade600,
);

final kHallTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.blueGrey.shade700,
);

final kFormFieldLabel = TextStyle(fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.bold);
// ==========================================================================

final kAddScheduleFormFiledDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 10),
  hintText: 'select hall',
  hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.75),
  ),
);

final kFindAHallFormFiledDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 10),
  hintText: 'select your entry',
  hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey.shade600),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.75),
  ),
);
