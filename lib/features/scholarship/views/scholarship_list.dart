import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:financial_aid_project/features/scholarship/controllers/scholarship_controllers.dart';
import 'package:financial_aid_project/features/scholarship/views/components/header.dart';
import 'package:financial_aid_project/features/scholarship/views/components/banner.dart';
import 'package:financial_aid_project/features/scholarship/views/components/filters.dart';
import 'package:financial_aid_project/features/scholarship/views/components/scholarship_card.dart';
import 'package:financial_aid_project/features/scholarship/views/scholarship_details.dart';
import '../models/scholarship.dart';

class ScholarshipList extends StatefulWidget {
  const ScholarshipList({super.key});

  @override
  State<ScholarshipList> createState() => _ScholarshipListState();
}

class _ScholarshipListState extends State<ScholarshipList> {
  final ScholarshipController _controller = ScholarshipController();
  late List<Scholarship> scholarships;
  bool meritBased = false;
  bool needBased = false;
  double gpa = 0.0;

  @override
  void initState() {
    super.initState();
    scholarships = _controller.getScholarships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.lightContainer,
      appBar: AppBar(
        title: const Text('Scholarships'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Sticky Header (Row1 and Row2)
          SliverToBoxAdapter(
            child: const Header(),
          ),
          // Sticky Row3
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: const StickyHeaderRow3(),
            ),
          ),
          // Banner Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: BannerWidget(
                onClick: () {
                  Navigator.pushNamed(context, '/profile-setup');
                },
              ),
            ),
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Row(
              children: [
                // Left Column: Filters
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Filters(
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
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2,
                      ),
                      itemCount: scholarships.length,
                      itemBuilder: (context, index) {
                        return ScholarshipCard(
                          scholarship: scholarships[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScholarshipDetails(
                                  scholarship: scholarships[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60.0; // Height of the sticky header
  @override
  double get minExtent => 60.0; // Height of the sticky header
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
