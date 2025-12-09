import 'package:flutter/material.dart';
import 'package:registration_form/models/user_model.dart';
import 'package:registration_form/screens/registration_page2.dart';
import 'package:registration_form/utils/constants.dart';
import 'package:registration_form/utils/validation_helper.dart';

class RegistrationPage1 extends StatefulWidget {
  final User? existingUser;

  const RegistrationPage1({super.key, this.existingUser});

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing user data if available
    final existingUser = widget.existingUser;
    _nameController = TextEditingController(text: existingUser?.name ?? '');
    _emailController = TextEditingController(text: existingUser?.email ?? '');
    _phoneController = TextEditingController(text: existingUser?.phone ?? '');
    _passwordController = TextEditingController(
      text: existingUser?.password ?? '',
    );
    _confirmPasswordController = TextEditingController(
      text: existingUser?.password ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  void _goToNextPage() async {
    if (_formKey.currentState!.validate()) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationPage2(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
            users: widget.existingUser,
          ),
        ),
      );

      if (result != null && result is User) {
        Navigator.pop(context, result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingUser != null;

    return Scaffold(
      body: Container(
        decoration: AppStyles.gradientBackground,
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        isEditing
                            ? 'Edit Personal Information'
                            : 'Personal Information',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isEditing ? 'Editing' : 'Step 1 of 2',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Progress Indicator
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Edit Mode Indicator
                          if (isEditing) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'You are editing your registration information.',
                                      style: AppStyles.bodyMedium.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          // Form Fields
                          Column(
                            children: [
                              // Full Name
                              TextFormField(
                                controller: _nameController,
                                decoration: AppStyles.inputDecoration(
                                  'Full Name',
                                  suffixIcon: const Icon(
                                    Icons.person_outline,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validateName(value),
                              ),
                              const SizedBox(height: 20),

                              // Email
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: AppStyles.inputDecoration(
                                  'Email Address',
                                  suffixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validateEmail(value),
                              ),
                              const SizedBox(height: 20),

                              // Phone Number
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: AppStyles.inputDecoration(
                                  'Phone Number',
                                  suffixIcon: const Icon(
                                    Icons.phone_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validatePhone(value),
                              ),
                              const SizedBox(height: 20),

                              // Password
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: AppStyles.inputDecoration(
                                  'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),

                                // validator: _validatePassword,
                                validator: (value) =>
                                    ValidationHelper.validatePassword(value),
                              ),
                              const SizedBox(height: 20),

                              // Confirm Password
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,
                                decoration: AppStyles.inputDecoration(
                                  'Confirm Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validateConfirmPass(
                                      value,
                                      _passwordController.text,
                                    ),
                              ),

                              const SizedBox(height: 40),

                              // Next Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _goToNextPage,
                                  icon: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 20,
                                  ),
                                  label: Text(
                                    isEditing
                                        ? 'Continue to Edit'
                                        : 'Continue to Next Step',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Clear Form Button (only in edit mode)
                              if (isEditing)
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {
                                      // Clear all fields
                                      _nameController.clear();
                                      _emailController.clear();
                                      _phoneController.clear();
                                      _passwordController.clear();
                                      _confirmPasswordController.clear();
                                      setState(() {
                                        _obscurePassword = true;
                                        _obscureConfirmPassword = true;
                                      });
                                    },
                                    child: const Text(
                                      'Clear Form',
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
