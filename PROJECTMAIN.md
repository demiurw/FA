## Project Overview

The goal of this project is to create a centralized, web-based platform that increases awareness of, and access to, scholarships and grants for Utech students. Built using Flutter and Firebase, the platform will not only help students assess their eligibility for financial aid but also guide them through the application process—from discovering opportunities and receiving personalized recommendations to tracking their application progress. Additionally, the platform offers coaching support and training to help students meet scholarship requirements.

---

## Functional and Non-Functional Requirements

### Functional Requirements

- **User Registration and Profile Management**  
   Students create and manage accounts with detailed profiles including personal, academic, and financial information. note it is best to allow them to sign up with username , email, password a first sign up but allow them to see scholarship but to access features like coaching etc must add additional information
- **Scholarship Discovery and Filtering**
  - **Search:** Keyword-based search functionality (e.g., “international student,” “STEM”).
  - **Advanced Filters:** Options to narrow down results by eligibility criteria, deadlines, funding amounts, and more.
- **Profile-Based Recommendations**  
   A recommendation engine matches students’ profiles—such as major, year, extracurricular activities, and academic performance—with suitable scholarships.
- **Application Guidance and Tracking**
  - **Step-by-Step Application Guidance:** Detailed instructions that walk students through the application process.
  - **Progress Tracking:** Tools to help students monitor deadlines, submission milestones, and coaching feedback.
- **Notifications and Reminders**  
   Integration with Flutter and Firebase Messaging to push alerts for new scholarship matches, application deadlines, and other important updates.
- **Social Media Integration**  
   Connect with popular social media platforms to allow easy sharing of scholarship opportunities and updates.

### Non-Functional Requirements

- **Responsiveness and Reliability**  
   The platform will be designed to perform seamlessly across various devices and network conditions.
- **Real-Time Updates**  
   Ensure timely information delivery regarding scholarship status, application changes, and deadline reminders.
- **Data Security and Privacy**  
   Implement robust security measures to protect personal and sensitive data.
- **Scalability**  
   Build with a modular approach to accommodate future feature extensions and increased user load.

---

## Recommender System

### Content-Based Filtering

- **Profile Attributes:**  
   Utilize detailed student profiles (e.g., major, academic performance, extracurricular activities) to compare with scholarship criteria.
- **Scoring Algorithm:** ??? ideas but suggest a better method if you can
  Develop a scoring system that assigns points based on the match between student attributes and scholarship requirements. This logic will be implemented through Firebase Functions.

### Optional Machine Learning Enhancement ????

ideas but suggest a better method if you can

- **TensorFlow Lite or Firebase ML:**  
   Explore ML models to refine recommendation accuracy. These models can learn from student interactions, adapting recommendations to user behavior over time.

---

## Notifications and Communication

- **Push Notifications:**  
   Use Flutter and Firebase Messaging to notify students of new matches, upcoming deadlines, and application updates.
- **Customizable Alerts:**  
   Allow users to choose their preferred method and frequency of notifications, ensuring timely reminders without information overload.

---

## Scholarship Data Gathering & Search Capabilities

### Data Gathering & Web Scraping

ideas but suggest a better method if you can

- **Data Extraction:**  
   Leverage Python libraries such as BeautifulSoup, Requests, and Scrapy to scrape scholarship data from various websites.
- **Integration with Firebase:**  
   Automate the process by using Firebase’s REST API or Python SDK to directly upload and update scholarship information in the database.

### Advanced Search & Filtering

- **Keyword Search:**  
   Implement a robust search bar that enables students to look up scholarships by specific keywords.
- **Advanced Filtering Options:**  
   Provide filters based on eligibility, deadlines, funding amounts, and other scholarship-specific criteria to streamline the search process.

---

## Database Schema

### Core Collections and Tables

1. **Users Collection**

   - **Fields:**
     - `user_id` (Primary Key)
     - `name`
     - `email`
     - `profile_data` (includes personal, academic, and financial details)

2. **Scholarship Information Collection**

   - **Fields:**
     - `scholarship_id`
     - `title`
     - `description`
     - `eligibility`
     - `deadline`
     - `application_link`
     - `scholarship_amount`
     - `currency`
     - `type`
     - `category`
     - `source_website`
     - `scraped_date`

3. **Organization/Provider Information**

   - **Fields:**
     - `provider_name`
     - `provider_website`
     - `provider_email`
     - `provider_phone`

4. **Location and Eligibility**

   - **Fields:**
     - `country`
     - `region`
     - `eligible_nationalities`
     - `eligible_institutions`

5. **Additional Details and Metadata**

   - **Fields:**
     - `requirements`
     - `benefits`
     - `notes`
     - `tags`
     - `is_active`
     - `last_updated`
     - `scraped_by`

---

## Detailed User Profile Structure

### 1. Personal Information

- **Basic Details:**  
   Full name, date of birth, gender.
- **Contact Information:**  
   Email address, phone number, and residential address.
- **Citizenship/Residency:**  
   Nationality and residency status, which are crucial for determining scholarship eligibility.

### 2. Academic Background

- **Educational History:**  
   Information about high school or current college, graduation year, and enrollment date.
- **Academic Performance:**  
   Current GPA, standardized test scores (SAT, ACT, etc.), academic achievements, honors, and awards.
- **Field of Study:**  
   Intended major or field of study to facilitate subject-specific scholarship matching.

### 3. Financial Information

- **Income and Need Assessment:**  
   Family income, income bracket, household dependents, and indicators of financial hardship.
- **Existing Aid:**  
   Details on current or past financial aid, grants, or scholarships, including FAFSA or CSS Profile information.

### 4. Extracurricular & Community Involvement

- **Activities and Leadership:**  
   Participation in clubs, sports, volunteer work, community service, and leadership roles.
- **Additional Achievements:**  
   Recognitions and awards beyond academics.

### 5. Scholarship History & Goals

- **Past Applications:**  
   Record of previously applied-for or received scholarships.
- **Personal Statement/Essays:**  
   A dedicated section to input or upload personal essays required by many scholarships.
- **Career and Educational Goals:**  
   Future aspirations to help match students with scholarships aligned with their career path.

### 6. Document Uploads & Verification

- **Supporting Documents:**  
   Options for uploading transcripts, recommendation letters, financial documents, and standardized test score reports.
- **Optional Attachments:**  
   Resumes or portfolios for merit-based awards.

### 7. Coaching & Support Needs

- **Areas for Improvement:**  
   Specific coaching needs (e.g., essay writing, interview preparation).
- **Progress Tracking:**  
   Fields to record milestones, deadlines, and feedback from coaches.
- **Communication Preferences:**  
   Students can set their preferred method and frequency for receiving notifications regarding deadlines, coaching sessions, and scholarship updates.

---

## Conclusion

This project is designed to empower Utech students by streamlining the scholarship application process and providing personalized support. By integrating a robust recommendation engine, real-time notifications, advanced search capabilities, and secure data handling—all built on Flutter and Firebase—the platform aims to maximize students’ chances of securing financial aid while also offering guidance and support every step of the way.
