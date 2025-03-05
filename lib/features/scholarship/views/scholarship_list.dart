import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/features/scholarship/controllers/scholarship_controllers.dart';
import 'package:financial_aid_project/features/scholarship/views/components/header.dart';
import 'package:financial_aid_project/features/scholarship/views/components/filters.dart';
import 'package:financial_aid_project/features/scholarship/views/components/scholarship_card.dart';
import '../models/scholarship.dart';

class ScholarshipList extends StatefulWidget {
  const ScholarshipList({super.key});

  @override
  _ScholarshipList createState() => _ScholarshipList();
}

class _ScholarshipList extends State<ScholarshipList> {
  final ScholarshipController _controller = ScholarshipController();
  late List<Scholarship> scholarships;
  String selectedParish = 'Kingston';
  bool meritBased = false;
  bool needBased = false;
  double gpa = 0.0;

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
  void initState() {
    super.initState();
    scholarships = _controller.getScholarships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.lightContainer,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Header(),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            // Left Column: Filters
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Filters(
                  jamaicanParishes: jamaicanParishes,
                  academicStages: academicStages,
                  degreeLevels: degreeLevels,
                  fieldsOfStudy: fieldsOfStudy,
                  meritBased: meritBased,
                  needBased: needBased,
                  gpa: gpa,
                  onMeritBasedChanged: (value) {
                    setState(() {
                      meritBased = value;
                    });
                  },
                  onNeedBasedChanged: (value) {
                    setState(() {
                      needBased = value;
                    });
                  },
                  onGpaChanged: (value) {
                    setState(() {
                      gpa = value;
                    });
                  },
                ),
              ),
            ),
            // Right Column: Scholarships List
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2,
                  ),
                  itemCount: scholarships.length,
                  itemBuilder: (context, index) {
                    return ScholarshipCard(scholarship: scholarships[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
