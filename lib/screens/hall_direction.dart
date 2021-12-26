import 'package:college/enums/entry_enum.dart';
import 'package:college/enums/hall_enum.dart';
import 'package:college/components/cookbooks/hall_position_box.dart';
import 'package:college/screens/hall_schedule.dart';
import 'package:flutter/material.dart';

class HallDirection extends StatelessWidget {
  static const String id = 'hall_direction';

  String getImageName(Map args) {
    String entryNumber = getEntryName(args['my_entry']).substring(getEntryName(args['my_entry']).length - 1);
    String hallNumber = getHallName(args['hall']).substring(getHallName(args['hall']).length - 1);
    return entryNumber + hallNumber + '.png';
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Hall Direction', style: TextStyle(fontWeight: FontWeight.w900))),
      body: Center(
        child: Container(
          height: 600,
          width: 380,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/${getImageName(args)}'))),
          child: Stack(
            children: [
              HallPositionBox(
                text: getHallName(Hall.hall1),
                bottom: 470,
                left: 250,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall1),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall2),
                bottom: 350,
                left: 270,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall2),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall3),
                bottom: 188,
                left: 275,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall3),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall4),
                bottom: 80,
                left: 250,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall4),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall5),
                bottom: 470,
                left: 20,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall5),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall6),
                bottom: 350,
                left: 10,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall6),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall7),
                bottom: 188,
                left: 8,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall7),
              ),
              HallPositionBox(
                text: getHallName(Hall.hall8),
                bottom: 80,
                left: 15,
                onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: Hall.hall8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
