import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/features/scholarship/models/scholarship.dart';
import 'package:financial_aid_project/features/scholarship/views/scholarship_details.dart';

class ScholarshipCard extends StatelessWidget {
  final Scholarship scholarship;
  final VoidCallback? onTap;

  const ScholarshipCard({
    super.key,
    required this.scholarship,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ScholarshipDetails(scholarship: scholarship),
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
              Text(
                scholarship.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                scholarship.amount,
                style:
                    const TextStyle(color: TColors.borderPrimary, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "Deadline: ${scholarship.deadline}",
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (scholarship.meritBased)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Chip(
                    label: const Text('Merit-Based',
                        style: TextStyle(fontSize: 12)),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
