import 'package:flutter/material.dart';
import 'package:registration_form/models/user_model.dart';
import 'package:registration_form/screens/registration_page1.dart';
import 'package:registration_form/utils/constants.dart';
import 'package:registration_form/services/storage_service.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await StorageService.getUser();
      setState(() {
        _userData = user;
        _isLoading = false;
      });
    } catch (e) {
      // print('Error loading user: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _startRegistration({User? existingUser}) async {
    // Navigate to Page 1 and pass existing user data for editing
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage1(
          existingUser: existingUser, // Pass user data for editing
        ),
      ),
    );

    // Check if we got updated user data back
    if (result != null && result is User) {
      setState(() {
        _userData = result;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            existingUser == null
                ? 'Registration Successful!'
                : 'Registration Updated!',
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  Future<void> _clearRegistration() async {
    try {
      await StorageService.clearUser();
      setState(() {
        _userData = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration data cleared'),
          backgroundColor: AppColors.textSecondary,
        ),
      );
    } catch (e) {
      print('Error clearing user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.gradientBackground,
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              top: -100,
              right: -90,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              right: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: 250,
              right: 260,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(
                    255,
                    161,
                    211,
                    145,
                  ).withOpacity(0.3),
                ),
              ),
            ),

            SafeArea(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            // Welcome Section
                            Container(
                              decoration: AppStyles.cardDecoration,
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Welcome to',
                                    style: AppStyles.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ERNI Registration',
                                    style: AppStyles.heading1.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Join our community by creating your account. '
                                    'We\'ll guide you through a quick registration process.',
                                    style: AppStyles.bodyLarge,
                                  ),
                                  const SizedBox(height: 32),
                                  // Registration Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _startRegistration,
                                      icon: const Icon(
                                        Icons.app_registration_rounded,
                                        size: 20,
                                      ),
                                      label: const Text('Start Registration'),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Display Submitted Data
                            if (_userData != null) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Registration Details',
                                    style: AppStyles.heading2.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _clearRegistration,
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Color.fromARGB(237, 204, 5, 5),
                                    ),
                                    tooltip: 'Clear Registration',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: AppStyles.cardDecoration,
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Success Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.success.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.success,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Registration Complete',
                                            style: AppStyles.bodyMedium
                                                .copyWith(
                                                  color: AppColors.success,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '(Saved Locally)',
                                            style: AppStyles.bodyMedium
                                                .copyWith(
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),

                                    // User Details
                                    _buildDetailItem('Name', _userData!.name),
                                    _buildDetailItem('Email', _userData!.email),
                                    _buildDetailItem('Phone', _userData!.phone),
                                    _buildDetailItem(
                                      'Age',
                                      '${_userData!.age} years old',
                                    ),
                                    _buildDetailItem(
                                      'Gender',
                                      _userData!.gender,
                                    ),
                                    _buildDetailItem(
                                      'Country',
                                      _userData!.country,
                                    ),
                                    if (_userData!.bio.isNotEmpty)
                                      _buildDetailItem('Bio', _userData!.bio),

                                    const SizedBox(height: 24),
                                    // Edit Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () => _startRegistration(
                                          existingUser: _userData,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.primary,
                                          side: const BorderSide(
                                            color: AppColors.primary,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),

                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit_rounded, size: 18),
                                            SizedBox(width: 8),
                                            Text('Edit Registration'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              // Empty State
                              Container(
                                decoration: AppStyles.cardDecoration,
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_add_alt_1,
                                      size: 64,
                                      color: AppColors.textSecondary
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No Registration Yet',
                                      style: AppStyles.heading2.copyWith(
                                        color: AppColors.textSecondary
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Start your registration journey by clicking the button above',
                                      textAlign: TextAlign.center,
                                      style: AppStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 150),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.labelText.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
