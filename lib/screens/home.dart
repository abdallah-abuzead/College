import 'package:college/Models/custom_user.dart';
import 'package:college/Models/schedule.dart';
import 'package:college/components/custom_buttons/rounded_button.dart';
import 'package:college/screens/search_result.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:college/enums/entry_enum.dart';
import '../constants.dart';
import 'login.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  List<String?> doctorsAndSubjects = [];
  String? searchText;
  Entry? selectedEntry;

  void findAHall() {
    var formData = _formKey.currentState;
    if (formData!.validate()) {
      formData.save();
      Navigator.pushNamed(context, SearchResult.id, arguments: {'my_entry': selectedEntry, 'my_search': searchText});
    }
  }

  getData() async {
    Schedule.getAllSchedules().then((schedules) {
      schedules.forEach((schedule) {
        if (!doctorsAndSubjects.contains(schedule.subject)) doctorsAndSubjects.add(schedule.subject);
        if (!doctorsAndSubjects.contains(schedule.doctor)) doctorsAndSubjects.add(schedule.doctor);
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  // this method is used for the AutoComplete Widget:
  List<String?> getSuggestions(String query) =>
      doctorsAndSubjects.where((str) => str!.toLowerCase().contains(query.toLowerCase())).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find A Hall', style: TextStyle(fontWeight: FontWeight.w900)),
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Doctor/ Subject', style: kFormFieldLabel),
                SizedBox(height: 10),
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _searchController,
                    decoration: kFindAHallFormFiledDecoration.copyWith(
                      suffixIcon: Icon(Icons.person, size: 25),
                      hintText: 'search by doctor, subject ...',
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please select doctor or subject.' : null,
                  onSaved: (value) => searchText = value!,
                  suggestionsCallback: (pattern) => getSuggestions(pattern),
                  itemBuilder: (context, suggestion) => ListTile(title: Text('$suggestion')),
                  onSuggestionSelected: (suggestion) => _searchController.text = suggestion.toString(),
                  transitionBuilder: (context, suggestionsBox, controller) => suggestionsBox,
                ),
                // =====================================================================
                Divider(color: Colors.grey, height: 60),
                // =====================================================================
                Text('Your Entry', style: kFormFieldLabel),
                SizedBox(height: 10),
                DropdownButtonFormField2(
                  decoration: kFindAHallFormFiledDecoration,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  items: entries.map<DropdownMenuItem<Entry>>((Entry entry) {
                    return DropdownMenuItem<Entry>(
                      value: entry,
                      child: Text(
                        getEntryName(entry),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {},
                  validator: (value) => value == null ? 'Please select your entry.' : null,
                  onSaved: (value) => selectedEntry = value as Entry?,
                ),
                // =====================================================================
                SizedBox(height: 70),
                RoundedButton(
                  title: 'Go',
                  colour: Colors.blueAccent,
                  onPressed: findAHall,
                  titleStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// InputDecoration(
// contentPadding: EdgeInsets.zero,
// border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// borderSide: BorderSide(color: Colors.grey.shade400, width: 1.75),
// ),
// ),
