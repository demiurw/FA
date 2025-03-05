import 'package:flutter/material.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row 1: Logo + Search Bar + Profile
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("LOGO",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Scholarships...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.notifications, size: 28),
                  SizedBox(width: 16),
                  CircleAvatar(child: Icon(Icons.person)),
                ],
              ),
            ],
          ),
        ),
        // Row 2: Navigation Tabs
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text("Scholarship Locator",
                      style: TextStyle(color: TColors.info))),
              TextButton(onPressed: () {}, child: Text("Coaching")),
              TextButton(onPressed: () {}, child: Text("Reports")),
            ],
          ),
        ),
        // Row 3: Search Bar + Saved Scholarships
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Scholarship Locator",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Find a Scholarship...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.star, color: Colors.orange),
                label: Text("Saved Scholarships (0)"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
