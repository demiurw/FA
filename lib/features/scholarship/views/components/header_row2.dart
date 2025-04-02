import 'package:flutter/material.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';

class HeaderRow2 extends StatelessWidget {
  const HeaderRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavLink(context, "Scholarship Locator", TColors.info),
          _buildNavLink(context, "Coaching", Colors.black),
          _buildNavLink(context, "Reports", Colors.black),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, Color color) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
