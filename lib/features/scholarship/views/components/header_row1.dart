import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';

class HeaderRow1 extends StatelessWidget {
  const HeaderRow1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Simple text-based logo
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: TColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.school, color: TColors.primary, size: 24),
                SizedBox(width: 8),
                Text(
                  "Financial Aid",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Scholarships...",
                  prefixIcon: const Icon(EvaIcons.search),
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: TColors.borderPrimary),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: TColors.primary),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: const [
              Icon(EvaIcons.bell, size: 28),
              SizedBox(width: 16),
              CircleAvatar(child: Icon(EvaIcons.person)),
            ],
          ),
        ],
      ),
    );
  }
}
