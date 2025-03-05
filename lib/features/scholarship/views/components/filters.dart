import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Filters extends StatelessWidget {
  final List<String> jamaicanParishes;
  final List<String> academicStages;
  final List<String> degreeLevels;
  final List<String> fieldsOfStudy;
  final bool meritBased;
  final bool needBased;
  final double gpa;
  final Function(bool) onMeritBasedChanged;
  final Function(bool) onNeedBasedChanged;
  final Function(double) onGpaChanged;

  Filters({
    required this.jamaicanParishes,
    required this.academicStages,
    required this.degreeLevels,
    required this.fieldsOfStudy,
    required this.meritBased,
    required this.needBased,
    required this.gpa,
    required this.onMeritBasedChanged,
    required this.onNeedBasedChanged,
    required this.onGpaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Filters",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Divider(),
        _buildExpandableDropdown(context, "Location", jamaicanParishes,
            "Select the location of your current residence and/or your home to see scholarships that are based on current location."),
        _buildExpandableDropdown(context, "Academic Stage", academicStages,
            "Select your current academic stage to find scholarships open to you."),
        _buildGpaField(context),
        _buildExpandableCheckbox(
            context,
            "Scholarship Type",
            ["Merit-Based", "Need-Based"],
            "Choose \"Merit-Based\" for scholarships awarded for academic achievements, or \"Need-Based\" for those given based on financial need."),
        _buildExpandableDropdown(context, "Degree Level", degreeLevels,
            "Select the degree level you're currently pursuing. Select \"Undergraduate\" to see programs for both Associate and Bachelor's degrees."),
        _buildExpandableSearchableDropdown(
            context,
            "Fields of Study",
            fieldsOfStudy,
            "Search scholarships by your intended, current, or past fields of study. This list is similar to college majors but also includes subjects that are not traditional academic fields."),
        _buildExpandableDropdown(context, "College", ["UTech", "UWI"],
            "Select your college. Default is UTech."),
      ],
    );
  }

  Widget _buildExpandableDropdown(BuildContext context, String title,
      List<String> options, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                if (options.length > 5)
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search by name",
                      suffixIcon: Icon(EvaIcons.search),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Search by name",
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(EvaIcons.search),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: options.map((option) {
                                        return ListTile(
                                          title: Text(option),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                else
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select an option",
                    ),
                    items: options
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGpaField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text("GPA"),
        trailing: Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Select or input GPA, rounding to the nearest 0.25, to see scholarships with a GPA requirement.",
                    style: TextStyle(fontSize: 12, color: TColors.darkGrey)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: gpa,
                        min: 0.0,
                        max: 4.5,
                        divisions: 16,
                        label: gpa.toStringAsFixed(2),
                        onChanged: (value) {
                          onGpaChanged(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(EvaIcons.editOutline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController gpaController =
                                TextEditingController(
                                    text: gpa.toStringAsFixed(2));
                            return AlertDialog(
                              title: Text("Enter GPA"),
                              content: TextField(
                                controller: gpaController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    onGpaChanged(
                                        double.tryParse(gpaController.text) ??
                                            gpa);
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableCheckbox(BuildContext context, String title,
      List<String> options, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                ...options.map((option) {
                  bool isChecked =
                      option == "Merit-Based" ? meritBased : needBased;
                  return CheckboxListTile(
                    title: Text(option),
                    value: isChecked,
                    onChanged: (value) {
                      if (option == "Merit-Based") {
                        onMeritBasedChanged(value!);
                      } else {
                        onNeedBasedChanged(value!);
                      }
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSearchableDropdown(BuildContext context, String title,
      List<String> options, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search by name",
                    suffixIcon: Icon(EvaIcons.search),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Search by name",
                                      prefixIcon: Icon(EvaIcons.search),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView(
                                    children: options.map((option) {
                                      return ListTile(
                                        title: Text(option),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
