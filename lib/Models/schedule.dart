import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/enums/hall_enum.dart';

CollectionReference _scheduleCollection = FirebaseFirestore.instance.collection('schedule');

class Schedule {
  String? id, subject, doctor, startTime, endTime;
  Hall? hall;
  Timestamp? date, createdAt, updatedAt;

  Schedule({
    required this.subject,
    required this.doctor,
    required this.hall,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Schedule.fromJson({required Map<String, dynamic> schedule, required String id}) {
    this.id = id;
    this.subject = schedule['subject'];
    this.doctor = schedule['doctor'];
    this.hall = getHallByName(schedule['hall']);
    this.date = schedule['date'];
    this.startTime = schedule['start_time'];
    this.endTime = schedule['end_time'];
    this.createdAt = schedule['created_at'];
    this.updatedAt = schedule['updated_at'];
  }

  Map<String, dynamic> toMap() => {
        'subject': this.subject,
        'doctor': this.doctor,
        'hall': getHallName(this.hall as Hall),
        'date': this.date,
        'start_time': this.startTime,
        'end_time': this.endTime,
        'created_at': this.createdAt,
        'updated_at': this.updatedAt,
      };

  static Future<List<Schedule>> getAllSchedules() async {
    List<Schedule> schedules = [];
    await _scheduleCollection.get().then((snapshots) {
      snapshots.docs.forEach((schedule) {
        schedules.add(Schedule.fromJson(schedule: schedule.data() as Map<String, dynamic>, id: schedule.id));
      });
    });
    return schedules;
  }

  Future add() async {
    this.createdAt = this.updatedAt = Timestamp.now();
    await _scheduleCollection
        .add(this.toMap())
        .then((value) => print('Schedule added'))
        .catchError((error) => print('Failed to add schedule: $error'));
  }

  static Future<List<Schedule>> getSchedulesByHall(Hall hall) async {
    List<Schedule> schedules = [];
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    await _scheduleCollection
        .where('hall', isEqualTo: getHallName(hall))
        .where('date', isGreaterThanOrEqualTo: today)
        .get()
        .then((snapshots) {
      snapshots.docs.forEach((schedule) {
        schedules.add(Schedule.fromJson(schedule: schedule.data() as Map<String, dynamic>, id: schedule.id));
      });
    });
    return schedules;
  }

  static Future<List<Schedule>> getSearchResult(String mySearch) async {
    List<Schedule> schedules = [];
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    await _scheduleCollection
        .where('doctor', isEqualTo: mySearch)
        .where('date', isGreaterThanOrEqualTo: today)
        .get()
        .then((snapshots) {
      snapshots.docs.forEach((schedule) {
        schedules.add(Schedule.fromJson(schedule: schedule.data() as Map<String, dynamic>, id: schedule.id));
      });
    });
    await _scheduleCollection
        .where('subject', isEqualTo: mySearch)
        .where('date', isGreaterThanOrEqualTo: today)
        .get()
        .then((snapshots) {
      snapshots.docs.forEach((schedule) {
        schedules.add(Schedule.fromJson(schedule: schedule.data() as Map<String, dynamic>, id: schedule.id));
      });
    });
    return schedules;
  }

  Future delete() async {
    await _scheduleCollection.doc(this.id).delete().then((value) => print('schedule deleted'));
  }
}
