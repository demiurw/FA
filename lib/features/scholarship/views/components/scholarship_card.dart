import 'package:flutter/material.dart';
import 'package:financial_aid_project/features/scholarship/models/scholarship.dart';
import 'package:financial_aid_project/features/scholarship/views/scholarship_details.dart';

class ScholarshipCard extends StatelessWidget {
  final Scholarship scholarship;

  ScholarshipCard({required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScholarshipDetails(scholarship: scholarship),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(scholarship.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(scholarship.amount,
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              Text("Deadline: ${scholarship.deadline}",
                  style: TextStyle(fontSize: 12)),
              if (scholarship.meritBased)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Chip(
                    label: Text('Merit-Based', style: TextStyle(fontSize: 12)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
