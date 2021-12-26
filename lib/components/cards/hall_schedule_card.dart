import 'package:college/Models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HallScheduleCard extends StatelessWidget {
  HallScheduleCard({required this.schedule});
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
              dense: true,
              leading: Icon(Icons.menu_book_sharp, color: Colors.green, size: 25),
              title: Text(
                '${schedule.subject}',
                style: TextStyle(color: Colors.teal.shade800, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.person, color: Colors.blueGrey, size: 25),
              title: Text(
                '${schedule.doctor}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.date_range_rounded, color: Colors.blueGrey, size: 25),
              title: Text(
                '${Jiffy(schedule.date?.toDate()).format('EEEE   dd/MM/yyyy')}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.timelapse, color: Colors.blue, size: 25),
              title: Row(
                children: [
                  Card(
                    color: Colors.teal,
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${schedule.startTime}',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.arrow_right_alt, color: Colors.blue.shade700, size: 35),
                  SizedBox(width: 20),
                  Card(
                    color: Colors.teal,
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        '${schedule.endTime}',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
