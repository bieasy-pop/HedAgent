import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// Shared account fields required by both the student and educator sign up
/// forms. Must be placed inside an ancestor [Form].
class CommonAccountFields extends StatelessWidget {
  const CommonAccountFields({
    super.key,
    required this.size,
    this.isEducator = false,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.otherNameController,
    required this.dateController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.selectedGender,
    required this.selectedUniversity,
    required this.onGenderChanged,
    required this.onUniversityChanged,
    required this.onPhoneChanged,
    required this.onPickDate,
  });

  final Size size;
  final bool isEducator;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController otherNameController;
  final TextEditingController dateController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final String? selectedGender;
  final String? selectedUniversity;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onUniversityChanged;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onPickDate;

  InputDecoration _decoration(
    String hintText, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
    );
  }

  String? _required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static final RegExp _emailRegExp = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$',
  );

  @override
  Widget build(BuildContext context) {
    final gap = Gap(14 / 844 * size.height);
    final labelGap = Gap(8 / 844 * size.height);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Texts.emailLabelText, style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _decoration(
            'mail@gmail.com',
            prefixIcon: const Icon(Icons.email_outlined, color: greyColor),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            if (!_emailRegExp.hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        gap,
        Text(Texts.passwordLabelText, style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: _decoration(
            '***********',
            prefixIcon: const Icon(Icons.lock_outlined, color: greyColor),
            suffixIcon: IconButton(
              onPressed: onTogglePasswordVisibility,
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility_sharp
                    : Icons.visibility_off_outlined,
                color: greyColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        gap,
        Text('Confirm Password', style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: confirmPasswordController,
          obscureText: !isConfirmPasswordVisible,
          decoration: _decoration(
            '***********',
            prefixIcon: const Icon(Icons.lock_outlined, color: greyColor),
            suffixIcon: IconButton(
              onPressed: onToggleConfirmPasswordVisibility,
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility_sharp
                    : Icons.visibility_off_outlined,
                color: greyColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        gap,
        Text(
          isEducator ? 'Title' : 'First Name',
          style: AppTextStyle.sevStyle,
        ),
        labelGap,
        TextFormField(
          controller: firstNameController,
          textCapitalization: TextCapitalization.words,
          decoration: _decoration(isEducator ? 'Dr.' : 'John'),
          validator: (value) =>
              _required(value, isEducator ? 'Title' : 'First name'),
        ),
        gap,
        Text('Last Name', style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: lastNameController,
          textCapitalization: TextCapitalization.words,
          decoration: _decoration('Doe'),
          validator: (value) => _required(value, 'Last name'),
        ),
        gap,
        Text('Other Name (optional)', style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: otherNameController,
          textCapitalization: TextCapitalization.words,
          decoration: _decoration('Enter other name'),
        ),
        gap,
        Text('University', style: AppTextStyle.sevStyle),
        labelGap,
        DropdownButtonFormField<String>(
          initialValue: selectedUniversity,
          decoration: _decoration('Select university'),
          items: const [
            DropdownMenuItem(
              value: 'McPherson',
              child: Text('McPherson University'),
            ),
          ],
          onChanged: onUniversityChanged,
          validator: (value) => _required(value, 'University'),
        ),
        gap,
        Text('Gender', style: AppTextStyle.sevStyle),
        labelGap,
        DropdownButtonFormField<String>(
          initialValue: selectedGender,
          decoration: _decoration('Select gender'),
          items: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onChanged: onGenderChanged,
          validator: (value) => _required(value, 'Gender'),
        ),
        gap,
        Text('Phone No', style: AppTextStyle.sevStyle),
        labelGap,
        IntlPhoneField(
          decoration: _decoration('Enter your phone number'),
          initialCountryCode: 'NG',
          onChanged: (phone) => onPhoneChanged(phone.completeNumber),
        ),
        gap,
        Text('Date of Birth', style: AppTextStyle.sevStyle),
        labelGap,
        TextFormField(
          controller: dateController,
          readOnly: true,
          onTap: onPickDate,
          decoration: const InputDecoration(
            hintText: 'Choose a date',
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          validator: (value) => _required(value, 'Date of birth'),
        ),
      ],
    );
  }
}
