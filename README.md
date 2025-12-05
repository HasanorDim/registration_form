# Multi-Page Registration Form

## Description

A Flutter application demonstrating navigation and form handling across multiple screens. Users can register by filling out a two-page form with validation. The application showcases proper state management, form validation, and data passing between screens in Flutter.

## Features

- Multi-screen navigation with proper back stack management
- Comprehensive form validation on all fields with user-friendly error messages
- Data passing between screens using constructor parameters
- Password confirmation with match validation
- Age verification (must be 18 or older)
- Gender selection via radio buttons
- Responsive UI with SingleChildScrollView for small screens
- Display of submitted registration data on home screen

## Screens

1. **Home Screen**: Welcome page with navigation to registration and display of submitted user data
2. **Registration Page 1**: Personal information form (name, email, phone, password, confirm password)
3. **Registration Page 2**: Additional information form (age, gender, country, bio)

## Validation Rules

- **Name**: Required, minimum 3 characters
- **Email**: Required, valid email format (contains '@' and '.')
- **Phone**: Required, minimum 10 digits, numeric only
- **Password**: Required, minimum 6 characters
- **Confirm Password**: Required, must match password exactly
- **Age**: Required, must be 18 or older, numeric only
- **Gender**: Required selection
- **Country**: Required
- **Bio**: Optional (can be empty)

## Project Structure
