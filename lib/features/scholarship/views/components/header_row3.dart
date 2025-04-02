import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';

class HeaderRow3 extends StatelessWidget {
  const HeaderRow3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Scholarship Locator",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Find a Scholarship...",
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
          const SizedBox(width: 16),
          TextButton.icon(
            onPressed: () {
              // Add action for saved scholarships
            },
            icon: const Icon(EvaIcons.starOutline, color: TColors.textGray),
            label: const Text("Saved Scholarships (0)"),
          ),
        ],
      ),
    );
  }
}
