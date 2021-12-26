import 'package:college/Models/custom_user.dart';
import 'package:college/Models/schedule.dart';
import 'package:college/components/cookbooks/show_snack_bar.dart';
import 'package:college/enums/hall_enum.dart';
import 'package:college/components/cards/hall_schedule_card.dart';
import 'package:college/enums/user_type_enum.dart';
import 'package:flutter/material.dart';

class HallSchedule extends StatefulWidget {
  static const String id = 'hall_schedule';

  @override
  _HallScheduleState createState() => _HallScheduleState();
}

class _HallScheduleState extends State<HallSchedule> {
  @override
  Widget build(BuildContext context) {
    Hall hall = ModalRoute.of(context)!.settings.arguments as Hall;
    UserType userType = UserType.user;
    CustomUser.getCurrentUser().then((user) => userType = user.userType as UserType);
    return Scaffold(
      appBar: AppBar(title: Text(getHallName(hall), style: TextStyle(fontWeight: FontWeight.w900))),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<Schedule>>(
        future: Schedule.getSchedulesByHall(hall),
        builder: (context, AsyncSnapshot<List<Schedule>> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, i) {
              Schedule schedule = snapshot.data![i];
              return Dismissible(
                key: Key('${schedule.id}'),
                background: Container(
                  color: Colors.red,
                  child: Align(
                    child: Padding(padding: EdgeInsets.only(left: 16), child: Icon(Icons.delete, size: 30)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                onDismissed: (direction) async {
                  await schedule.delete();
                  dangerSnackBar(context, 'Schedule has been deleted successfully.');
                },
                direction: userType != UserType.user ? DismissDirection.startToEnd : DismissDirection.none,
                child: HallScheduleCard(schedule: schedule),
              );
            },
          );
        },
      ),
    );
  }
}
