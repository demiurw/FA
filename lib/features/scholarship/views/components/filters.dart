import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Filters extends StatefulWidget {
  final bool meritBased;
  final bool needBased;
  final double gpa;
  final Function(bool) onMeritBasedChanged;
  final Function(bool) onNeedBasedChanged;
  final Function(double) onGpaChanged;

  const Filters({
    super.key,
    required this.meritBased,
    required this.needBased,
    required this.gpa,
    required this.onMeritBasedChanged,
    required this.onNeedBasedChanged,
    required this.onGpaChanged,
  });

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  // Filter data encapsulated within the widget
  final List<String> jamaicanParishes = [
    "Kingston",
    "St. Andrew",
    "St. Thomas",
    "Portland",
    "St. Mary",
    "St. Ann",
    "Trelawny",
    "St. James",
    "Hanover",
    "Westmoreland",
    "St. Elizabeth",
    "Manchester",
    "Clarendon",
    "St. Catherine"
  ];

  final List<String> academicStages = [
    "High School",
    "College",
    "Postgraduate",
    "Other"
  ];

  final List<String> degreeLevels = [
    "Professional Certification",
    "Undergraduate",
    "Postgraduate"
  ];

  final List<String> fieldsOfStudy = [
    "Accounting",
    "Agriculture",
    "Architecture",
    "Art & Design",
    "Biology",
    "Business Administration",
    "Chemistry",
    "Computer Science",
    "Dentistry",
    "Economics",
    "Education",
    "Engineering",
    "Environmental Science",
    "Finance",
    "Health Sciences",
    "History",
    "Hospitality Management",
    "Law",
    "Literature",
    "Marketing",
    "Mathematics",
    "Medicine",
    "Nursing",
    "Pharmacy",
    "Physics",
    "Political Science",
    "Psychology",
    "Public Administration",
    "Social Work",
    "Sociology",
    "Sports Science",
    "Tourism Management",
    "Veterinary Science"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filters",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        _buildExpandableDropdown(
          context,
          "Location",
          jamaicanParishes,
          "Select the location of your current residence and/or your home to see scholarships that are based on current location.",
        ),
        _buildExpandableDropdown(
          context,
          "Academic Stage",
          academicStages,
          "Select your current academic stage to find scholarships open to you.",
        ),
        _buildGpaField(context),
        _buildExpandableCheckbox(
          context,
          "Scholarship Type",
          ["Merit-Based", "Need-Based"],
          "Choose \"Merit-Based\" for scholarships awarded for academic achievements, or \"Need-Based\" for those given based on financial need.",
        ),
        _buildExpandableDropdown(
          context,
          "Degree Level",
          degreeLevels,
          "Select the degree level you're currently pursuing. Select \"Undergraduate\" to see programs for both Associate and Bachelor's degrees.",
        ),
        _buildExpandableSearchableDropdown(
          context,
          "Fields of Study",
          fieldsOfStudy,
          "Search scholarships by your intended, current, or past fields of study. This list is similar to college majors but also includes subjects that are not traditional academic fields.",
        ),
      ],
    );
  }

  Widget _buildExpandableDropdown(
    BuildContext context,
    String title,
    List<String> options,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: const Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
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
        title: const Text("GPA"),
        trailing: const Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select or input GPA, rounding to the nearest 0.25, to see scholarships with a GPA requirement.",
                  style: TextStyle(fontSize: 12, color: TColors.darkGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: widget.gpa,
                        min: 0.0,
                        max: 4.5,
                        divisions: 16,
                        label: widget.gpa.toStringAsFixed(2),
                        onChanged: (value) {
                          widget.onGpaChanged(value);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(EvaIcons.editOutline),
                      onPressed: () {
                        TextEditingController gpaController =
                            TextEditingController(
                                text: widget.gpa.toStringAsFixed(2));
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Enter GPA"),
                              content: TextField(
                                controller: gpaController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.onGpaChanged(
                                        double.tryParse(gpaController.text) ??
                                            widget.gpa);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
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

  Widget _buildExpandableCheckbox(
    BuildContext context,
    String title,
    List<String> options,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: const Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                ...options.map((option) {
                  bool isChecked = option == "Merit-Based"
                      ? widget.meritBased
                      : widget.needBased;
                  return CheckboxListTile(
                    title: Text(option),
                    value: isChecked,
                    onChanged: (value) {
                      if (option == "Merit-Based") {
                        widget.onMeritBasedChanged(value!);
                      } else {
                        widget.onNeedBasedChanged(value!);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSearchableDropdown(
    BuildContext context,
    String title,
    List<String> options,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        trailing: const Icon(EvaIcons.plus),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search by name",
                    suffixIcon: Icon(EvaIcons.search),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(
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
