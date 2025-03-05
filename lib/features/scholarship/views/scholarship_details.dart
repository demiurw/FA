import 'package:flutter/material.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scholarship.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Chip(
              label:
                  Text('Deadline Soon', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ),
            const SizedBox(height: 16),
            Container(
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text('Deadline: ${scholarship.deadline}'),
                  const SizedBox(height: 12),
                  Text('Merit-Based: ${scholarship.meritBased ? "Yes" : "No"}'),
                  Text('Need-Based: ${scholarship.needBased ? "Yes" : "No"}'),
                  Text(
                      'Essay Required: ${scholarship.essayRequired ? "Yes" : "No"}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Apply Now',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
