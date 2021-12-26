import 'package:college/Models/schedule.dart';
import 'package:college/components/cards/search_schedule_card.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);
  static const String id = 'search_result';

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text('Find A Hall', style: TextStyle(fontWeight: FontWeight.w900))),
      body: FutureBuilder<List<Schedule>>(
        future: Schedule.getSearchResult(args['my_search']),
        builder: (context, AsyncSnapshot<List<Schedule>> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, i) {
              return SearchScheduleCard(data: args, schedule: snapshot.data![i]);
            },
          );
        },
      ),
    );
  }
}
