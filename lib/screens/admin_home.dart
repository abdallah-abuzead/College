import 'package:college/Models/custom_user.dart';
import 'package:college/enums/hall_enum.dart';
import 'package:college/components/cards/hall_card.dart';
import 'package:college/screens/add_schedule.dart';
import 'package:college/screens/login.dart';
import 'package:flutter/material.dart';
import 'hall_schedule.dart';

class AdminHome extends StatefulWidget {
  static const String id = 'admin_home';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              CustomUser.signOut();
              Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
            },
          )
        ],
      ),
      backgroundColor: Colors.blue,
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 1.45,
        ),
        itemCount: halls.length + 1,
        itemBuilder: (context, i) {
          return i < halls.length
              ? GridTile(
                  child: HallCard(
                    text: getHallName(halls[i]).toUpperCase(),
                    onTap: () => Navigator.pushNamed(context, HallSchedule.id, arguments: halls[i]),
                  ),
                )
              : GridTile(
                  child: HallCard(
                    text: 'Add Schedule',
                    icon: Icons.add_box,
                    onTap: () => Navigator.pushNamed(context, AddSchedule.id),
                  ),
                );
        },
      ),
    );
  }
}
