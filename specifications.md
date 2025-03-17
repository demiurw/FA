Implement a complete authentication system using Cloud Firestore based on the following requirements:

Initial Screen & Routing:

On app startup, display a home screen that allows either a user or an admin to sign in.
Include a sign-up option exclusively for new users.
Firestore Collections:

Assume a pre-existing "Admins" collection in Cloud Firestore.
Add a default admin record to this collection with the following details:
Username: Admin1
Password: Providence#7
Include any additional fields you consider necessary (for example, email, role, creation timestamp, etc.).
Models & Classes:

Create all necessary models (e.g., an Admin model) and helper methods for admin authentication and authorization.
Ensure separation between user and admin data handling.
Dashboard Separation:

Rename the existing dashboard for regular users (e.g., "User Dashboard") to clearly distinguish it from the admin view.
Develop an Admin Dashboard that includes a feature for adding a new admin to the Firestore "Admins" collection. This should be the only permitted method for admin sign-up, ensuring admin creation is restricted.
Testing:

Implement and test the full authentication flow to ensure that both user and admin logins, as well as new user sign-ups and admin additions, work seamlessly without errors.
