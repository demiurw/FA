import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_aid_project/data/repositories/authentication/admin_model.dart';

/// Script to add the default admin to Firestore.
/// This should be run only once during initial setup.
class DefaultAdminCreator {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a default admin account with predefined credentials.
  static Future<void> createDefaultAdmin() async {
    try {
      // 0. Make sure we're not creating an admin while someone is logged in
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }

      // 1. Check if admin already exists to avoid duplicates (by email)
      try {
        await _auth.signInWithEmailAndPassword(
          email: 'admin@financialaid.com',
          password: 'Providence#7',
        );

        // If we get here, the admin account exists in Authentication

        // Check if admin exists in Firestore
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          final adminDoc =
              await _db.collection('Admins').doc(currentUser.uid).get();

          if (!adminDoc.exists) {
            // Admin exists in Auth but not in Firestore, create the Firestore record
            final admin = AdminModel(
              id: currentUser.uid,
              username: 'Admin1',
              email: 'admin@financialaid.com',
              firstName: 'System',
              lastName: 'Admin',
              createdAt: DateTime.now(),
            );

            await _db.collection('Admins').doc(admin.id).set(admin.toJson());
          }
        }

        // Sign out after checking
        await _auth.signOut();
        return;
      } catch (e) {
        // Admin doesn't exist, continue with creation
      }

      // 2. Create admin account in Firebase Auth with valid credentials
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: 'admin@financialaid.com',
        password: 'Providence#7',
      );

      // 3. Create admin record in Firestore
      final admin = AdminModel(
        id: userCredential.user!.uid,
        username: 'Admin1',
        email: 'admin@financialaid.com',
        firstName: 'System',
        lastName: 'Admin',
        createdAt: DateTime.now(),
      );

      await _db.collection('Admins').doc(admin.id).set(admin.toJson());

      // 4. Sign out after creation
      await _auth.signOut();
    } catch (e) {
      // Silently ignore errors, as this is just a setup script
    }
  }
}
