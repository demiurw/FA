import 'package:financial_aid_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:financial_aid_project/shared_components/responsive_builder.dart';
import '../models/scholarship.dart';

class ScholarshipDetails extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarshipDetails({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholarship Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality would be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Save/bookmark functionality would be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return _buildMobileLayout(context);
        },
        tabletBuilder: (context, constraints) {
          return _buildTabletLayout(context);
        },
        desktopBuilder: (context, constraints) {
          return _buildDesktopLayout(context);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Apply functionality would be implemented here
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Application feature coming soon')),
          );
        },
        backgroundColor: TColors.primary,
        label: const Text('Apply Now'),
        icon: const Icon(Icons.send),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            scholarship.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Chip(
                label: Text('Deadline Soon',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
              const SizedBox(width: 8),
              if (scholarship.meritBased)
                const Chip(
                  label: Text('Merit-Based',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blue,
                ),
              if (scholarship.needBased)
                const Chip(
                  label:
                      Text('Need-Based', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.orange,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScholarshipDetails(context),
                  const SizedBox(height: 24),
                  _buildApplicationRequirements(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scholarship.title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Chip(
                      label: Text('Deadline Soon',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    if (scholarship.meritBased)
                      const Chip(
                        label: Text('Merit-Based',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ),
                    if (scholarship.needBased)
                      const Chip(
                        label: Text('Need-Based',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.orange,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScholarshipDetails(context),
                        const SizedBox(height: 24),
                        _buildApplicationRequirements(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildSidebar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scholarship.title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Chip(
                      label: Text('Deadline Soon',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    if (scholarship.meritBased)
                      const Chip(
                        label: Text('Merit-Based',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ),
                    const SizedBox(width: 8),
                    if (scholarship.needBased)
                      const Chip(
                        label: Text('Need-Based',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.orange,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScholarshipDetails(context),
                        const SizedBox(height: 24),
                        _buildApplicationRequirements(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 2,
            child: _buildSidebar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScholarshipDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About the Scholarship',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Awarded up to: ${scholarship.amount}',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text('Deadline: ${scholarship.deadline}'),
          const SizedBox(height: 12),
          Text('Merit-Based: ${scholarship.meritBased ? "Yes" : "No"}'),
          Text('Need-Based: ${scholarship.needBased ? "Yes" : "No"}'),
          if (scholarship.requiredGpa != null)
            Text('Minimum GPA: ${scholarship.requiredGpa}'),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(scholarship.description),
          if (scholarship.eligibility != null) ...[
            const SizedBox(height: 16),
            const Text(
              'Eligibility',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(scholarship.eligibility!),
          ],
        ],
      ),
    );
  }

  Widget _buildApplicationRequirements(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Application Requirements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildRequirementItem(
            icon: Icons.assignment,
            title: 'Personal Statement',
            description:
                'A 500-word personal statement explaining why you deserve this scholarship.',
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            icon: Icons.school,
            title: 'Academic Transcripts',
            description:
                'Official or unofficial transcripts showing your academic history.',
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            icon: Icons.person,
            title: 'Letters of Recommendation',
            description:
                'Two letters of recommendation from teachers or mentors.',
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scholarship Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSidebarItem(
            icon: Icons.calendar_today,
            title: 'Application Deadline',
            value: scholarship.deadline,
          ),
          const Divider(),
          _buildSidebarItem(
            icon: Icons.attach_money,
            title: 'Award Amount',
            value: scholarship.amount,
          ),
          const Divider(),
          _buildSidebarItem(
            icon: Icons.school,
            title: 'Source',
            value: scholarship.sourceName,
          ),
          const Divider(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Apply action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Application feature coming soon')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Apply Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (scholarship.applicationLink != null)
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Open application link
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Opening link: ${scholarship.applicationLink}')),
                  );
                },
                child: const Text('Visit Source Website'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
