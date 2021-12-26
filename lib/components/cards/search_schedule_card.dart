import 'package:college/Models/schedule.dart';
import 'package:college/enums/hall_enum.dart';
import 'package:college/screens/hall_direction.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../../constants.dart';

class SearchScheduleCard extends StatelessWidget {
  SearchScheduleCard({required this.data, required this.schedule});

  final Map data;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Card(
        color: Colors.teal.shade50,
        elevation: 3,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              HallDirection.id,
              arguments: {'my_entry': data['my_entry'], 'hall': schedule.hall},
            );
          },
          contentPadding: EdgeInsets.only(top: 5, left: 20),
          leading: Icon(Icons.class__outlined, size: 30, color: Colors.greenAccent.shade700),
          title: Text('${getHallName(schedule.hall as Hall)}', style: kHallTitleTextStyle),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Text('Subject:  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${schedule.subject}', style: kDoctorSubjectTextStyle),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Doctor:    ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${schedule.doctor}', style: kDoctorSubjectTextStyle),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Date:       ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    '${Jiffy(schedule.date?.toDate()).format('EEEE   dd/MM/yyyy')}',
                    style: kDoctorSubjectTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Text('Time:      ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${schedule.startTime}', style: kFromToTextStyle),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_right_alt, size: 30, color: Colors.greenAccent.shade700),
                  SizedBox(width: 10),
                  Text('${schedule.endTime}', style: kFromToTextStyle)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
