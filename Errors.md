rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
// Allow admin access to all collections
match /{document=\*\*} {
allow read, write: if request.auth != null &&
exists(/databases/$(database)/documents/Admins/$(request.auth.uid));
}

    // Allow the scraper service account to write to these collections
    match /scholarships/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }

    match /admin_notifications/{document} {
      allow read, write: if request.auth != null;
    }

    match /scraper_triggers/{document} {
      allow read, write: if request.auth != null;
    }

    // Allow users to create their own profile document
    match /Users/{userId} {
      allow create: if request.auth != null && request.auth.uid == userId;
      allow read, update: if request.auth != null && (request.auth.uid == userId ||
                            exists(/databases/$(database)/documents/Admins/$(request.auth.uid)));
    }

}
}
