import 'package:flutter/material.dart';
import 'package:registration_form/models/user_model.dart';
import 'package:registration_form/utils/constants.dart';
import 'package:registration_form/utils/validation_helper.dart';

class RegistrationPage2 extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String password;
  final User? users;

  const RegistrationPage2({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.users,
  });

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late TextEditingController _countryController;
  late TextEditingController _bioController;
  late String _selectedGender;

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing user data
    _ageController = TextEditingController(
      text: widget.users?.age?.toString() ?? '',
    );
    _countryController = TextEditingController(
      text: widget.users?.country ?? '',
    );
    _bioController = TextEditingController(text: widget.users?.bio ?? '');
    _selectedGender = widget.users?.gender ?? 'Male';
  }

  @override
  void dispose() {
    _ageController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _goback() {
    Navigator.pop(context);
  }

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      final user = User(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
        password: widget.password,
        age: int.parse(_ageController.text),
        country: _countryController.text,
        bio: _bioController.text,
        gender: _selectedGender,
      );

      Navigator.pop(context, user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.users != null;
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
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: Colors.white,
                      onPressed: _goback,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        isEditing
                            ? 'Edit Additional Information'
                            : 'Additional Information',
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
                        isEditing ? 'Editing' : 'Step 2 of 2',
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
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // User Info Summary
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isEditing
                                      ? 'Your Current Information'
                                      : 'Personal Information Summary',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Name: ${widget.name}'),
                                const SizedBox(height: 4),
                                Text('Email: ${widget.email}'),
                                const SizedBox(height: 4),
                                Text('Phone: ${widget.phone}'),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Age
                              Text('Age', style: AppStyles.labelText),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                decoration: AppStyles.inputDecoration(
                                  'Enter your age',
                                  suffixIcon: const Icon(
                                    Icons.cake_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validateAge(value),
                              ),

                              const SizedBox(height: 20),

                              // Gender
                              Text('Gender', style: AppStyles.labelText),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedGender,
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: AppColors.textSecondary,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    style: AppStyles.bodyMedium.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                    items: _genders
                                        .map(
                                          (gender) => DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Country
                              Text('Country/City', style: AppStyles.labelText),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _countryController,
                                decoration: AppStyles.inputDecoration(
                                  'Enter your country or city',
                                  suffixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                validator: (value) =>
                                    ValidationHelper.validateContry(value),
                              ),

                              const SizedBox(height: 20),

                              // Bio
                              Text(
                                'Bio (Optional)',
                                style: AppStyles.labelText,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _bioController,
                                maxLines: 3,
                                decoration: AppStyles.inputDecoration(
                                  'Tell us about yourself...',
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: _goback,
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        side: const BorderSide(
                                          color: AppColors.primary,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        isEditing ? 'Save Changes' : 'Submit',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
