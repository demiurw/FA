import 'package:financial_aid_project/features/authentication/controllers/admin_controller.dart';
import 'package:financial_aid_project/data/repositories/authentication/authentication_repository.dart';
import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:financial_aid_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthenticationRepository.instance.logout(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'Manage Admins', icon: Icon(Icons.admin_panel_settings)),
            Tab(text: 'Web Scraper', icon: Icon(Icons.web)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AdminDashboardOverview(),
          AdminManagementTab(),
          WebScraperManagementTab(),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to the Admin Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  'Users',
                  Icons.people,
                  Colors.blue,
                  'Manage user accounts',
                  () {},
                ),
                _buildDashboardCard(
                  'Scholarships',
                  Icons.school,
                  Colors.green,
                  'Add and manage scholarships',
                  () => Get.toNamed(TRoutes.scholarshipList),
                ),
                _buildDashboardCard(
                  'Applications',
                  Icons.description,
                  Colors.orange,
                  'View and process applications',
                  () {},
                ),
                _buildDashboardCard(
                  'Reports',
                  Icons.bar_chart,
                  Colors.purple,
                  'View analytics and reports',
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color,
      String description, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Manage Administrators',
                style: TextStyle(
                  fontSize: 24,
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
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_showAddAdminForm) _buildAddAdminForm(),
          if (!_showAddAdminForm) _buildAdminList(),
        ],
      ),
    );
  }

  Widget _buildAddAdminForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.firstName,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
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
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
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
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
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
                    border: const OutlineInputBorder(),
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
                    border: const OutlineInputBorder(),
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
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: controller.getAllAdmins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final admins = snapshot.data;

          if (admins == null || admins.isEmpty) {
            return const Center(
              child: Text('No admins found.'),
            );
          }

          return ListView.builder(
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final admin = admins[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: TColors.primary,
                    child: Text(
                      admin.firstName.isNotEmpty && admin.lastName.isNotEmpty
                          ? '${admin.firstName[0]}${admin.lastName[0]}'
                              .toUpperCase()
                          : admin.username.isNotEmpty
                              ? admin.username[0].toUpperCase()
                              : 'A',
                    ),
                  ),
                  title: Text(
                      '${admin.firstName} ${admin.lastName}'.trim().isNotEmpty
                          ? '${admin.firstName} ${admin.lastName}'
                          : admin.username),
                  subtitle: Text(admin.email),
                  trailing: Text('Admin'),
                ),
              );
            },
          );
        },
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scholarship Web Scraper',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Scraping Statistics Card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scraping Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Statistics content
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('scholarships').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final scholarships = snapshot.data?.docs ?? [];
                        final totalCount = scholarships.length;

                        // Count merit-based scholarships
                        final meritBasedCount = scholarships
                            .where((doc) => doc['meritBased'] == true)
                            .length;

                        // Count need-based scholarships
                        final needBasedCount = scholarships
                            .where((doc) => doc['needBased'] == true)
                            .length;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatisticRow(
                                'Total Scholarships', totalCount.toString()),
                            _buildStatisticRow(
                                'Merit-Based', meritBasedCount.toString()),
                            _buildStatisticRow(
                                'Need-Based', needBasedCount.toString()),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Recent Scraper Notifications
          Text(
            'Recent Scraper Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
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

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        notifications[index].data() as Map<String, dynamic>;
                    final timestamp = notification['timestamp'] as Timestamp?;
                    final formattedDate = timestamp != null
                        ? DateFormat('yyyy-MM-dd HH:mm')
                            .format(timestamp.toDate())
                        : 'Unknown date';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.web, color: Colors.blue),
                        title: Text(
                            notification['message'] ?? 'Unknown notification'),
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
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Manual Trigger Button
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Trigger Manual Scrape'),
            onPressed: _triggerManualScrape,
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _triggerManualScrape() async {
    try {
      // Show confirmation dialog
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Trigger Manual Scrape'),
          content: const Text(
              'This will trigger a manual web scraping job. The process may take several minutes to complete. Do you want to continue?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Triggering manual scrape...'),
            ],
          ),
        ),
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

        // Dismiss loading dialog
        if (mounted) Navigator.of(context).pop();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Manual scraping job triggered successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        // Dismiss loading dialog if showing
        if (mounted) Navigator.of(context).pop();

        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Dismiss loading dialog if showing
      if (mounted) Navigator.of(context).pop();

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
