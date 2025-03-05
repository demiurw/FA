import '../models/scholarship.dart';

class ScholarshipController {
  List<Scholarship> getScholarships() {
    return [
      Scholarship(
        title: 'UTech Open Scholarship',
        amount: '\$50,000',
        deadline: '31/7/2025',
        meritBased: true,
        needBased: true,
        essayRequired: true,
      ),
      Scholarship(
        title: 'National Youth Scholarship',
        amount: '\$25,000',
        deadline: '15/6/2025',
        meritBased: false,
        needBased: true,
        essayRequired: false,
      ),
      Scholarship(
        title: 'STEM Future Leaders',
        amount: '\$40,000',
        deadline: '20/8/2025',
        meritBased: true,
        needBased: false,
        essayRequired: true,
      ),
    ];
  }
}
