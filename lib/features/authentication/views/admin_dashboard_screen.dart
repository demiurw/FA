import 'package:financial_aid_project/features/authentication/controllers/admin_controller.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:financial_aid_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:financial_aid_project/features/scholarship/controllers/scholarship_controllers.dart';
import 'package:financial_aid_project/features/scholarship/models/scholarship.dart';
import 'package:financial_aid_project/utils/popups/loaders.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(),

          // Main content
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      AdminDashboardOverview(),
                      ScholarshipManagementTab(),
                      AdminManagementTab(),
                      WebScraperManagementTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: TColors.primary.withAlpha(15),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // App logo/branding
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ScholarsHub',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                      ),
                    ),
                    Text(
                      'Admin Portal',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // Navigation menu
          _buildNavItem(
              0, 'Dashboard', Icons.dashboard_outlined, Icons.dashboard),
          _buildNavItem(1, 'Scholarships', Icons.school_outlined, Icons.school),
          _buildNavItem(2, 'Admin Management',
              Icons.admin_panel_settings_outlined, Icons.admin_panel_settings),
          _buildNavItem(3, 'Web Scraper', Icons.web_outlined, Icons.web),

          const Divider(height: 40),

          // Extra menu items
          _buildMenuLink('Settings', Icons.settings_outlined, () {}),

          const Spacer(),

          // Logout button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withAlpha(30),
                foregroundColor: Colors.red,
                elevation: 0,
                minimumSize: const Size(double.infinity, 46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int index, String title, IconData outlinedIcon, IconData filledIcon) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _tabController.animateTo(index);
        });
      },
      child: Container(
        height: 54,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? TColors.primary.withAlpha(30) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? TColors.primary : Colors.grey,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? TColors.primary : Colors.grey[700],
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMenuLink(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Page title
          Text(
            _currentIndex == 0
                ? 'Dashboard Overview'
                : _currentIndex == 1
                    ? 'Scholarship Management'
                    : _currentIndex == 2
                        ? 'Admin Management'
                        : 'Web Scraper',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          // Search bar (optional)
          Container(
            width: 300,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[400], size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Admin account info
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: TColors.primary,
                child: Text('A', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              const Text(
                'Admin',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey[600], size: 16),
            ],
          ),
        ],
      ),
    );
  }
}

/// Dashboard Overview Tab
class AdminDashboardOverview extends StatelessWidget {
  const AdminDashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('scholarships').snapshots(),
        builder: (context, snapshot) {
          // Get scholarship data
          final scholarshipsCount =
              snapshot.hasData ? snapshot.data!.docs.length : 0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick stats section
                _buildQuickStats(scholarshipsCount),

                const SizedBox(height: 30),

                // Two column layout for middle section
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    // Two column layout for wider screens
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column (60% width)
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRecentActivity(),
                              const SizedBox(height: 24),
                              _buildScholarshipTypeBreakdown(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // Right column (40% width)
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCalendarCard(),
                              const SizedBox(height: 24),
                              _buildTodoListCard(),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Single column layout for smaller screens
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRecentActivity(),
                        const SizedBox(height: 24),
                        _buildScholarshipTypeBreakdown(),
                        const SizedBox(height: 24),
                        _buildCalendarCard(),
                        const SizedBox(height: 24),
                        _buildTodoListCard(),
                      ],
                    );
                  }
                }),

                const SizedBox(height: 30),

                // Action cards
                _buildActionCards(),
              ],
            ),
          );
        });
  }

  Widget _buildQuickStats(int scholarshipsCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TColors.primary, TColors.primary.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to ScholarsHub Admin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stats row with SingleChildScrollView to prevent overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildQuickStatItem(
                  scholarshipsCount.toString(),
                  'Total Scholarships',
                  Icons.school,
                ),
                _buildQuickStatItem('0', 'Active Users', Icons.person),
                _buildQuickStatItem('0', 'Applications', Icons.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatItem(String value, String label, IconData icon) {
    return Container(
      // Remove fixed width to avoid overflow
      width: null,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Only take needed space
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    color: TColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildActivityItem(
              'New scholarship added',
              'Engineering Scholarship for STEM Students',
              '10 minutes ago',
              Colors.green,
            ),
            const Divider(),
            _buildActivityItem(
              'User registered',
              'James Wilson completed registration',
              '1 hour ago',
              Colors.blue,
            ),
            const Divider(),
            _buildActivityItem(
              'Application submitted',
              'Emma Davis applied for Mathematics Grant',
              '3 hours ago',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String description, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScholarshipTypeBreakdown() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scholarship Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Type breakdown
            Row(
              children: [
                _buildTypeBreakdownItem('Merit-Based', '45%', Colors.orange),
                _buildTypeBreakdownItem('Need-Based', '30%', Colors.green),
                _buildTypeBreakdownItem('Others', '25%', Colors.blue),
              ],
            ),

            const SizedBox(height: 20),

            // Simple bar chart
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                _buildCategoryBar('Engineering', 0.8, Colors.blue),
                const SizedBox(height: 10),
                _buildCategoryBar('Medical', 0.65, Colors.green),
                const SizedBox(height: 10),
                _buildCategoryBar('Business', 0.5, Colors.orange),
                const SizedBox(height: 10),
                _buildCategoryBar('Arts', 0.35, Colors.purple),
                const SizedBox(height: 10),
                _buildCategoryBar('Others', 0.2, Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBreakdownItem(String label, String percentage, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                percentage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('${(percentage * 100).toInt()}%'),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 20),

            // Month picker with proper constraints
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_ios, size: 14),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          DateFormat('MMMM yyyy').format(DateTime.now()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: TColors.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 12,
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Calendar header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Mo', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Tu', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('We', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Th', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Fr', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Sa', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('Su', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 10),

            // Calendar grid (simplified)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: 30, // Simplified
              itemBuilder: (context, index) {
                final day = index + 1;
                final isToday = day == DateTime.now().day;
                final hasEvent = [5, 12, 18, 25].contains(day);

                return Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isToday ? TColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (hasEvent)
                        Positioned(
                          bottom: 2,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isToday ? Colors.white : TColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoListCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To-Do List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.add_circle_outline, color: TColors.primary),
              ],
            ),
            const SizedBox(height: 20),

            // Todo items
            _buildTodoItem('Review new scholarship applications', true),
            _buildTodoItem('Update scholarship deadlines', false),
            _buildTodoItem('Send newsletter to registered users', false),
            _buildTodoItem('Check web scraper results', false),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoItem(String task, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted ? TColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isCompleted ? null : Border.all(color: Colors.grey),
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              task,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Use SingleChildScrollView for action cards to prevent overflow on small screens
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 240,
                child: _buildActionCard(
                  'Manage Scholarships',
                  'Add, edit or delete scholarship listings',
                  Icons.school,
                  const Color(0xFF4361EE),
                  () => Get.toNamed(TRoutes.scholarshipList),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 240,
                child: _buildActionCard(
                  'User Management',
                  'View and manage user accounts',
                  Icons.people,
                  const Color(0xFF3A0CA3),
                  () {},
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 240,
                child: _buildActionCard(
                  'System Settings',
                  'Configure system parameters',
                  Icons.settings,
                  const Color(0xFF7209B7),
                  () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon,
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Admin Management Tab
class AdminManagementTab extends StatefulWidget {
  const AdminManagementTab({super.key});

  @override
  State<AdminManagementTab> createState() => _AdminManagementTabState();
}

class _AdminManagementTabState extends State<AdminManagementTab> {
  final controller = Get.find<AdminController>();
  bool _showAddAdminForm = false;

  // Create a local form key for the add admin form
  final _addAdminFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Manage Administrators',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(_showAddAdminForm ? Icons.close : Icons.add),
                    label: Text(_showAddAdminForm ? 'Cancel' : 'Add Admin'),
                    onPressed: () {
                      setState(() {
                        _showAddAdminForm = !_showAddAdminForm;
                        if (!_showAddAdminForm) {
                          controller.username.clear();
                          controller.firstName.clear();
                          controller.lastName.clear();
                          controller.email.clear();
                          controller.password.clear();
                          controller.confirmPassword.clear();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _showAddAdminForm ? Colors.red : TColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_showAddAdminForm) _buildAddAdminForm() else _buildAdminList(),
        ],
      ),
    );
  }

  Widget _buildAddAdminForm() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _addAdminFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Administrator',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.firstName,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: controller.lastName,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.username,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  controller: controller.confirmPassword,
                  obscureText: controller.hideConfirmPassword.value,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hideConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.hideConfirmPassword.value =
                            !controller.hideConfirmPassword.value;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_addAdminFormKey.currentState!.validate()) {
                      controller.addNewAdmin();
                      setState(() {
                        _showAddAdminForm = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Admin Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder<List<dynamic>>(
            future: controller.getAllAdmins(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  ),
                );
              }

              final admins = snapshot.data;

              if (admins == null || admins.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(Icons.people_outline,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No admins found.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: admins.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final admin = admins[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[index % Colors.primaries.length]
                          .withAlpha(50),
                      child: Text(
                        admin.firstName.isNotEmpty && admin.lastName.isNotEmpty
                            ? '${admin.firstName[0]}${admin.lastName[0]}'
                                .toUpperCase()
                            : admin.username.isNotEmpty
                                ? admin.username[0].toUpperCase()
                                : 'A',
                        style: TextStyle(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      '${admin.firstName} ${admin.lastName}'.trim().isNotEmpty
                          ? '${admin.firstName} ${admin.lastName}'
                          : admin.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(admin.email),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: TColors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Admin',
                        style: TextStyle(
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Web Scraper Management Tab
class WebScraperManagementTab extends StatefulWidget {
  const WebScraperManagementTab({super.key});

  @override
  State<WebScraperManagementTab> createState() =>
      _WebScraperManagementTabState();
}

class _WebScraperManagementTabState extends State<WebScraperManagementTab> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form controllers for adding new scraping source
  final TextEditingController _sourceNameController = TextEditingController();
  final TextEditingController _sourceUrlController = TextEditingController();

  @override
  void dispose() {
    _sourceNameController.dispose();
    _sourceUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScrapingStatisticsCard(),
          const SizedBox(height: 24),
          _buildActionsCard(),
          const SizedBox(height: 24),
          _buildScraperActivitySection(),
        ],
      ),
    );
  }

  Widget _buildScrapingStatisticsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics, color: TColors.primary),
                SizedBox(width: 12),
                Text(
                  'Scraping Statistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Statistics content
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('scholarships').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final scholarships = snapshot.data?.docs ?? [];
                  final totalCount = scholarships.length;

                  // Count merit-based scholarships
                  final meritBasedCount = scholarships.where((doc) {
                    final data = doc.data() as Map<String, dynamic>?;
                    return data != null && data['meritBased'] == true;
                  }).length;

                  // Count need-based scholarships
                  final needBasedCount = scholarships.where((doc) {
                    final data = doc.data() as Map<String, dynamic>?;
                    return data != null && data['needBased'] == true;
                  }).length;

                  return Container(
                    decoration: BoxDecoration(
                      color: TColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatisticItem(
                          Icons.school,
                          'Total',
                          totalCount.toString(),
                          Colors.blue,
                        ),
                        _buildStatisticItem(
                          Icons.workspace_premium,
                          'Merit-Based',
                          meritBasedCount.toString(),
                          Colors.amber,
                        ),
                        _buildStatisticItem(
                          Icons.attach_money,
                          'Need-Based',
                          needBasedCount.toString(),
                          Colors.green,
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(
      IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.settings, color: TColors.primary),
                SizedBox(width: 12),
                Text(
                  'Scraper Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Source'),
                    onPressed: _showAddSourceDialog,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: TColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Trigger Scrape'),
                    onPressed: _triggerManualScrape,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScraperActivitySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.notifications, color: TColors.primary),
                SizedBox(width: 12),
                Text(
                  'Recent Scraper Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('admin_notifications')
                    .where('type', isEqualTo: 'scraper_notification')
                    .orderBy('timestamp', descending: true)
                    .limit(10)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final notifications = snapshot.data?.docs ?? [];

                  if (notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_off,
                              size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No scraper activity found',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final notification =
                          notifications[index].data() as Map<String, dynamic>;
                      final timestamp = notification['timestamp'] as Timestamp?;
                      final formattedDate = timestamp != null
                          ? DateFormat('yyyy-MM-dd HH:mm')
                              .format(timestamp.toDate())
                          : 'Unknown date';

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: notification['read'] == true
                                ? Colors.grey.withAlpha(30)
                                : TColors.primary.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.web,
                            color: notification['read'] == true
                                ? Colors.grey
                                : TColors.primary,
                          ),
                        ),
                        title: Text(
                          notification['message'] ?? 'Unknown notification',
                          style: TextStyle(
                            fontWeight: notification['read'] == true
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(formattedDate),
                        trailing: notification['read'] == true
                            ? const Icon(Icons.visibility, color: Colors.grey)
                            : const Icon(Icons.visibility_off,
                                color: Colors.red),
                        onTap: () {
                          if (notification['read'] != true) {
                            // Mark as read
                            _firestore
                                .collection('admin_notifications')
                                .doc(notifications[index].id)
                                .update({'read': true});
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddSourceDialog() {
    final sourceNameController = TextEditingController();
    final sourceUrlController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Add Scraping Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: sourceNameController,
              decoration: const InputDecoration(
                labelText: 'Source Name',
                hintText: 'e.g., University Scholarships',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sourceUrlController,
              decoration: const InputDecoration(
                labelText: 'Source URL',
                hintText: 'e.g., https://example.com/scholarships',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement adding source
              Get.back(); // Close dialog
              TLoaders.successSnackBar(
                  title: 'Success', message: 'Source added successfully');

              // Clean up controllers
              sourceNameController.dispose();
              sourceUrlController.dispose();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add Source'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _triggerManualScrape() async {
    try {
      // Show confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Trigger Manual Scrape'),
          content: const Text(
              'This will trigger a manual web scraping job. The process may take several minutes to complete. Do you want to continue?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
        barrierDismissible: false,
      );

      if (confirmed != true) return;

      // Show loading dialog
      Get.dialog(
        const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Triggering manual scrape...'),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      try {
        // Create a trigger document to notify the scraper
        await _firestore.collection('scraper_triggers').add({
          'timestamp': FieldValue.serverTimestamp(),
          'type': 'manual',
          'status': 'pending',
          'triggered_by': 'admin',
        });

        // Add notification
        await _firestore.collection('admin_notifications').add({
          'message': 'Manual scraping job triggered by admin',
          'timestamp': FieldValue.serverTimestamp(),
          'type': 'scraper_notification',
          'read': false,
        });

        // Close dialog and show success message
        Get.back(); // Close loading dialog
        TLoaders.successSnackBar(
            title: 'Success',
            message: 'Manual scraping job triggered successfully');
      } catch (e) {
        // Close dialog and show error
        Get.back(); // Close loading dialog
        TLoaders.errorSnackBar(title: 'Error', message: e.toString());
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}

/// Scholarship Management Tab
class ScholarshipManagementTab extends StatefulWidget {
  const ScholarshipManagementTab({super.key});

  @override
  State<ScholarshipManagementTab> createState() =>
      _ScholarshipManagementTabState();
}

class _ScholarshipManagementTabState extends State<ScholarshipManagementTab> {
  final controller = Get.put(ScholarshipController());
  bool _showAddScholarshipForm = false;
  Scholarship? _scholarshipToEdit;

  // Controllers for form fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _eligibilityController = TextEditingController();
  final _applicationLinkController = TextEditingController();
  final _sourceWebsiteController = TextEditingController();
  final _sourceNameController = TextEditingController();
  final _gpaController = TextEditingController();

  // Form values
  bool _meritBased = false;
  bool _needBased = false;
  List<String> _selectedCategories = [];

  // Available categories
  final List<String> _availableCategories = [
    'Engineering',
    'Medicine',
    'Arts',
    'Science',
    'Business',
    'Law',
    'Computer Science',
    'Mathematics',
    'Social Sciences',
    'Humanities',
    'Education',
    'Nursing',
    'Pharmacy',
    'Dentistry',
    'Architecture',
  ];

  // Create a local form key for the add scholarship form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set up listeners for success and error messages
    _setupMessageListeners();
  }

  void _setupMessageListeners() {
    // Listen for changes to success message
    ever(controller.successMessage, (message) {
      if (message.isNotEmpty) {
        TLoaders.successSnackBar(title: 'Success', message: message);
        // Clear the message after showing the snackbar
        Future.delayed(const Duration(seconds: 3), () {
          controller.successMessage.value = '';
        });
      }
    });

    // Listen for changes to error message
    ever(controller.errorMessage, (message) {
      if (message.isNotEmpty) {
        TLoaders.errorSnackBar(title: 'Error', message: message);
        // Clear the message after showing the snackbar
        Future.delayed(const Duration(seconds: 3), () {
          controller.errorMessage.value = '';
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _deadlineController.dispose();
    _eligibilityController.dispose();
    _applicationLinkController.dispose();
    _sourceWebsiteController.dispose();
    _sourceNameController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _titleController.clear();
    _descriptionController.clear();
    _amountController.clear();
    _deadlineController.clear();
    _eligibilityController.clear();
    _applicationLinkController.clear();
    _sourceWebsiteController.clear();
    _sourceNameController.clear();
    _gpaController.clear();
    _meritBased = false;
    _needBased = false;
    _selectedCategories = [];
    _scholarshipToEdit = null;
  }

  void _populateFormForEdit(Scholarship scholarship) {
    _titleController.text = scholarship.title;
    _descriptionController.text = scholarship.description;
    _amountController.text = scholarship.amount;
    _deadlineController.text = scholarship.deadline;
    _eligibilityController.text = scholarship.eligibility ?? '';
    _applicationLinkController.text = scholarship.applicationLink ?? '';
    _sourceWebsiteController.text = scholarship.sourceWebsite;
    _sourceNameController.text = scholarship.sourceName;
    _gpaController.text = scholarship.requiredGpa?.toString() ?? '';
    _meritBased = scholarship.meritBased;
    _needBased = scholarship.needBased;
    _selectedCategories = List.from(scholarship.categories);
    _scholarshipToEdit = scholarship;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create scholarship object
      final scholarship = _scholarshipToEdit?.copyWith(
            title: _titleController.text,
            description: _descriptionController.text,
            amount: _amountController.text,
            deadline: _deadlineController.text,
            eligibility: _eligibilityController.text.isEmpty
                ? null
                : _eligibilityController.text,
            applicationLink: _applicationLinkController.text.isEmpty
                ? null
                : _applicationLinkController.text,
            sourceWebsite: _sourceWebsiteController.text,
            sourceName: _sourceNameController.text,
            meritBased: _meritBased,
            needBased: _needBased,
            requiredGpa: _gpaController.text.isEmpty
                ? null
                : double.tryParse(_gpaController.text),
            categories: _selectedCategories,
          ) ??
          Scholarship(
            id: '',
            title: _titleController.text,
            description: _descriptionController.text,
            amount: _amountController.text,
            deadline: _deadlineController.text,
            eligibility: _eligibilityController.text.isEmpty
                ? null
                : _eligibilityController.text,
            applicationLink: _applicationLinkController.text.isEmpty
                ? null
                : _applicationLinkController.text,
            sourceWebsite: _sourceWebsiteController.text,
            sourceName: _sourceNameController.text,
            meritBased: _meritBased,
            needBased: _needBased,
            requiredGpa: _gpaController.text.isEmpty
                ? null
                : double.tryParse(_gpaController.text),
            categories: _selectedCategories,
          );

      bool success;
      if (_scholarshipToEdit != null) {
        // Update existing scholarship
        success = await controller.updateScholarship(scholarship);
      } else {
        // Create new scholarship
        success = await controller.createScholarship(scholarship);
      }

      if (success) {
        setState(() {
          _showAddScholarshipForm = false;
          _resetForm();
        });
      }
    }
  }

  Future<void> _confirmDelete(Scholarship scholarship) async {
    Get.defaultDialog(
      title: 'Confirm Delete',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Text(
          'Are you sure you want to delete ${scholarship.title}?',
          textAlign: TextAlign.center,
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back(); // Close dialog
          controller.deleteScholarship(scholarship.id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        child: const Text('Delete'),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(), // Close dialog
        child: const Text('Cancel'),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Manage Scholarships',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon:
                        Icon(_showAddScholarshipForm ? Icons.close : Icons.add),
                    label: Text(
                        _showAddScholarshipForm ? 'Cancel' : 'Add Scholarship'),
                    onPressed: () {
                      setState(() {
                        _showAddScholarshipForm = !_showAddScholarshipForm;
                        if (!_showAddScholarshipForm) {
                          _resetForm();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showAddScholarshipForm
                          ? Colors.red
                          : TColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_showAddScholarshipForm)
            _buildScholarshipForm()
          else
            _buildScholarshipsList(),
        ],
      ),
    );
  }

  Widget _buildScholarshipForm() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _scholarshipToEdit == null
                    ? 'Add New Scholarship'
                    : 'Edit Scholarship',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Basic Info Section
              _buildSectionTitle('Basic Information'),

              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter scholarship title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter scholarship description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'e.g. \$5,000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _deadlineController,
                      decoration: InputDecoration(
                        labelText: 'Deadline',
                        hintText: 'e.g. May 15, 2024',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(const Duration(days: 30)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365 * 2)),
                            );
                            if (date != null) {
                              setState(() {
                                _deadlineController.text =
                                    DateFormat('MMMM d, yyyy').format(date);
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a deadline';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Eligibility Section
              _buildSectionTitle('Eligibility Requirements'),

              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Merit-Based'),
                      value: _meritBased,
                      onChanged: (value) {
                        setState(() {
                          _meritBased = value ?? false;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Need-Based'),
                      value: _needBased,
                      onChanged: (value) {
                        setState(() {
                          _needBased = value ?? false;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _gpaController,
                decoration: InputDecoration(
                  labelText: 'Required GPA (optional)',
                  hintText: 'e.g. 3.5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _eligibilityController,
                decoration: InputDecoration(
                  labelText: 'Additional Eligibility Details (optional)',
                  hintText: 'Enter any additional eligibility requirements',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              // Categories Section
              _buildSectionTitle('Categories'),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableCategories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: TColors.primary.withAlpha(100),
                    checkmarkColor: TColors.primary,
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Source Section
              _buildSectionTitle('Source Information'),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _sourceNameController,
                      decoration: InputDecoration(
                        labelText: 'Source Name',
                        hintText: 'e.g. University Foundation',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter source name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _sourceWebsiteController,
                      decoration: InputDecoration(
                        labelText: 'Source Website',
                        hintText: 'e.g. https://example.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter website';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _applicationLinkController,
                decoration: InputDecoration(
                  labelText: 'Application Link (optional)',
                  hintText: 'e.g. https://example.com/apply',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _scholarshipToEdit == null
                                  ? 'Create Scholarship'
                                  : 'Update Scholarship',
                              style: const TextStyle(fontSize: 16),
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildScholarshipsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.scholarships.isEmpty) {
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined,
                      size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No scholarships found',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      controller.fetchScholarships();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search scholarships...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  // Search functionality can be implemented here
                },
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Deadline',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.scholarships.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final scholarship = controller.scholarships[index];
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          scholarship.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(scholarship.amount),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(scholarship.deadline),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            if (scholarship.meritBased)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withAlpha(50),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Merit',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            if (scholarship.needBased)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withAlpha(50),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Need',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _showAddScholarshipForm = true;
                                  _populateFormForEdit(scholarship);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20),
                              color: Colors.red,
                              onPressed: () => _confirmDelete(scholarship),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
