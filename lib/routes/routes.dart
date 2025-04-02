class TRoutes {
  static const home = '/';
  static const login = '/login';
  static const signup = '/signup';

  // Route for the screen where users enter their email to request password reset
  static const forgetPassword = '/forgetPassword';

  // Not currently used - Firebase handles the reset UI externally
  // static const resetPassword = '/resetPassword';

  static const userDashboard = '/user-dashboard';
  static const adminDashboard = '/admin-dashboard';
  static const scholarshipList = '/scholarships';
  static const scholarshipDetails = '/scholarship-details';
}
