import 'package:flutter/material.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';

class BannerWidget extends StatelessWidget {
  final VoidCallback onClick;

  const BannerWidget({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100, // Adjust height as needed
      margin: const EdgeInsets.symmetric(
          vertical: 16), // Add spacing around the banner
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/bannerbg.png', // Path to your image
          ),
          fit: BoxFit.cover, // Adjust fit as needed
        ), // Optional: Add rounded corners
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Complete user profile sign up for a personalised Experience",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Ensure text is visible on the image
            ),
          ),
          ElevatedButton(
            onPressed: onClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: TColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("CLICK HERE",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
