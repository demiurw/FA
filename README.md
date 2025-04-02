# Financial Aid Project

A Flutter application for managing financial aid and scholarships, with user authentication and admin management.

## Project Overview

This application helps users explore and apply for scholarships and financial aid opportunities. It features a user authentication system, admin dashboard, and responsive UI for web platforms.

## Features

- User authentication (email/password)
- Admin dashboard for managing scholarships and applications
- Responsive UI design for web
- Firebase integration for backend services
- Automated web scraping for scholarship data collection

## Planned Features

### Authentication Improvements

- Password recovery and reset functionality
- Email verification for new accounts
- Social authentication (Google, Apple Sign-in)
- Multi-factor authentication
- User profile management
- Account settings and preferences
- Session management and security enhancements

### User Experience

- Improved navigation with browser history support
- Enhanced error messaging and feedback
- Loading states and animations
- User activity tracking

## Project Structure

```
lib/
├── data/
│   ├── repositories/      # Data repositories and API integrations
│   └── users/             # User-related data models and services
├── features/
│   ├── authentication/    # Authentication feature modules
│   │   ├── controllers/   # Authentication logic controllers
│   │   └── views/         # Authentication UI screens
│   └── scholarship/       # Scholarship feature modules
├── routes/                # Application routing
│   ├── app_routes.dart    # Route definitions
│   ├── routes.dart        # Route constants
│   ├── routes_middleware.dart # Route guard middleware
│   └── route_observer.dart    # Route observation utilities
├── utils/
│   ├── constants/         # App-wide constants (colors, sizes, etc.)
│   ├── exceptions/        # Custom exception handlers
│   ├── formatters/        # Data formatters and parsers
│   ├── helpers/           # Helper functions
│   ├── loaders/           # Loading indicators and utilities
│   ├── popups/            # Dialog and popup utilities
│   ├── scripts/           # Utility scripts (admin creation, etc.)
│   ├── themes/            # App theming
│   └── validators/        # Form validation logic
├── firebase_options.dart  # Firebase configuration
└── main.dart              # Application entry point

python_scraper/           # Python-based web scraper for scholarship data
├── config.py             # Configuration for the scraper
├── firebase_client.py    # Firebase integration for storing data
├── scraper.py            # Main scraper implementation
├── scheduler.py          # Scheduler for running the scraper periodically
├── setup.py              # Setup helper script
├── requirements.txt      # Python dependencies
├── .env.example          # Example environment configuration
├── Dockerfile            # Docker configuration for containerized deployment
└── docker-compose.yml    # Docker Compose configuration
```

## Technologies Used

- Flutter 3.x
- Firebase (Authentication, Firestore, Storage)
- GetX for state management
- Material Design components
- Python for web scraping (Playwright, BeautifulSoup)

### Installation

1. Clone this repository

   ```
   git clone https://github.com/DarrenV2/Financial-Aid-Platform-Project.git
   ```

2. Install dependencies

   ```
   flutter pub get
   ```

3. Run the application
   ```
   flutter run
   ```

## Default Admin Account

A default admin account is automatically created during the first run with the following credentials:

- Email: admin@financialaid.com
- Password: Providence#7

## Web Scraper

The project includes a Python-based web scraper for collecting scholarship data:

### Features

- Automated collection of scholarship information from multiple websites
- Integration with Firebase Firestore
- Intelligent categorization of scholarships
- Scheduled scraping with configurable intervals
- Manual trigger via admin dashboard

### Setup

See the instructions in `python_scraper/README.md` for detailed setup and usage information.

### Running the Scraper

```bash
cd python_scraper
python setup.py       # First-time setup
python scheduler.py   # Start the scheduler
```

For Docker deployment:

```bash
cd python_scraper
docker-compose up -d
```

## Browser Navigation

The application uses GetX for navigation and properly configures web URL strategy for clean URLs without hash fragments. However, be aware that the authentication flow (login/logout) intentionally clears navigation history for security purposes, which affects browser back button functionality after these operations.

## File Organization and Architecture

**Note**: The project's file organization is in active development and is inconsistent. Several improvements are planned:

- Optimize folder structure for consistency and maintainability
- Resolve architectural inconsistencies in the data layer
- Set up testing infrastructure
- Maybe move to a fully feature Based architecture
