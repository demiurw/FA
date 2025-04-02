# Architecture Documentation

This document explains the feature-based architecture used in the Financial Aid Project.

## Overview

The project follows a feature-based architecture, which organizes code around features rather than technical layers. This approach makes it easier to understand the codebase, maintain it, and add new features.

## Directory Structure

```
lib/
├── data/                       # Data layer
│   ├── models/                 # Data models
│   │   ├── user/               # User-related models
│   │   └── admin/              # Admin-related models
│   └── repositories/           # Data access repositories
│       ├── authentication/     # Authentication-related repositories
│       ├── users/              # User-related repositories
│       └── admin/              # Admin-related repositories
├── features/                   # Feature modules
│   ├── authentication/         # Authentication feature
│   │   ├── controllers/        # Business logic for authentication
│   │   └── views/              # UI screens for authentication
│   └── scholarship/            # Scholarship feature (to be implemented)
├── routes/                     # Application routing
├── utils/                      # Utilities and helpers
└── main.dart                   # Application entry point
```

## Naming Conventions

1. **Files**: Use snake_case for file names (e.g., `user_model.dart`, `admin_repository.dart`)
2. **Classes**: Use PascalCase for class names (e.g., `UserModel`, `AdminRepository`)
3. **Variables/Methods**: Use camelCase for variables and methods (e.g., `userId`, `getUser()`)
4. **Constants**: Use ALL_CAPS for constants (e.g., `API_URL`)

## Layer Responsibilities

### Models Layer

- Represents data structures
- Contains data validation logic
- Provides serialization/deserialization (toJson/fromJson methods)
- Located in `lib/data/models/`

### Repositories Layer

- Provides data access logic
- Handles API calls and database operations
- Manages caching strategies
- Located in `lib/data/repositories/`

### Features Layer

- Organized by application features
- Contains controllers (business logic) and views (UI)
- Each feature is isolated from others
- Located in `lib/features/`

## Best Practices

1. Keep feature directories self-contained
2. Follow single responsibility principle
3. Use dependency injection with GetX
4. Keep controllers focused on business logic
5. Keep views focused on UI representation
6. Use repositories for all data operations

## Adding New Features

When adding a new feature:

1. Create a new directory under `features/`
2. Add controllers and views directories within the feature
3. Add any feature-specific models in `data/models/feature_name/`
4. Add any feature-specific repositories in `data/repositories/feature_name/`
5. Register routes in `routes/` directory
