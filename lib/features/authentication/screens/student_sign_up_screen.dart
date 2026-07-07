import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/features/authentication/bloc/auth_bloc.dart';
import 'package:hedagent/features/authentication/bloc/auth_event.dart';
import 'package:hedagent/features/authentication/bloc/auth_state.dart';
import 'package:hedagent/features/authentication/data/models/register_request.dart';
import 'package:hedagent/features/authentication/widgets/common_account_fields.dart';
import 'package:hedagent/route/app_router_names.dart';
import 'package:intl/intl.dart';

class StudentSignUpScreen extends StatelessWidget {
  const StudentSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: const _StudentSignUpView(),
    );
  }
}

class _StudentSignUpView extends StatefulWidget {
  const _StudentSignUpView();

  @override
  State<_StudentSignUpView> createState() => _StudentSignUpViewState();
}

class _StudentSignUpViewState extends State<_StudentSignUpView> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _matricNoController = TextEditingController();
  final TextEditingController _programmeController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _yearOfAdmissionController =
      TextEditingController();
  final TextEditingController _expectedGraduationController =
      TextEditingController();

  String? _selectedGender;
  String? _selectedCollege;
  String? _selectedDepartment;
  String? _selectedUniversity;
  String _phoneNumber = '';
  DateTime? _selectedDate;

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _onSignUpPressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = RegisterRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      otherName: _otherNameController.text.trim().isEmpty
          ? null
          : _otherNameController.text.trim(),
      universityName: _selectedUniversity ?? '',
      role: 'student',
      phoneNumber: _phoneNumber,
      gender: _selectedGender ?? '',
      dateOfBirth: DateFormat('yyyy-MM-dd').format(_selectedDate!),
      studentData: StudentData(
        studentNumber: _matricNoController.text.trim(),
        faculty: _selectedCollege ?? '',
        department: _selectedDepartment ?? '',
        programme: _programmeController.text.trim(),
        level: _levelController.text.trim(),
        yearOfAdmission: _yearOfAdmissionController.text.trim(),
        expectedGraduation: _expectedGraduationController.text.trim(),
      ),
    );

    context.read<AuthBloc>().add(RegisterRequested(request));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _otherNameController.dispose();
    _dateController.dispose();
    _matricNoController.dispose();
    _programmeController.dispose();
    _levelController.dispose();
    _yearOfAdmissionController.dispose();
    _expectedGraduationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: redColor),
          );
        } else if (state is RegisterSuccess) {
          context.goNamed(RouteNames.homeString);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(Texts.appNameText, style: AppTextStyle.firStyle),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(32 / 844 * size.height),
                Center(
                  child: Container(
                    height: 0.65 * size.height,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(32.0 / 844 * size.height),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create your student account',
                            style: AppTextStyle.twentSixStyle,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Join the network of empathetic intelligence in education.',
                            style: AppTextStyle.nintStyle,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(24 / 844 * size.height),
                                    CommonAccountFields(
                                      size: size,
                                      emailController: _emailController,
                                      passwordController: _passwordController,
                                      confirmPasswordController:
                                          _confirmPasswordController,
                                      firstNameController: _firstNameController,
                                      lastNameController: _lastNameController,
                                      otherNameController: _otherNameController,
                                      dateController: _dateController,
                                      isPasswordVisible: isPasswordVisible,
                                      isConfirmPasswordVisible:
                                          isConfirmPasswordVisible,
                                      onTogglePasswordVisibility: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      onToggleConfirmPasswordVisibility: () {
                                        setState(() {
                                          isConfirmPasswordVisible =
                                              !isConfirmPasswordVisible;
                                        });
                                      },
                                      selectedUniversity: _selectedUniversity,
                                      onUniversityChanged: (value) {
                                        setState(() {
                                          _selectedUniversity = value;
                                        });
                                      },
                                      selectedGender: _selectedGender,
                                      onGenderChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                      onPhoneChanged: (value) {
                                        _phoneNumber = value;
                                      },
                                      onPickDate: _pickDate,
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'Matric No',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    TextFormField(
                                      controller: _matricNoController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your matric number',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      validator: (value) => _requiredValidator(
                                        value,
                                        'Matric number',
                                      ),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'College',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    DropdownButtonFormField<String>(
                                      initialValue: _selectedCollege,
                                      decoration: InputDecoration(
                                        hintText: 'Select college',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'COLCOM',
                                          child: Text('College of Computing'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCollege = value;
                                        });
                                      },
                                      validator: (value) =>
                                          _requiredValidator(value, 'College'),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'Department',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    DropdownButtonFormField<String>(
                                      initialValue: _selectedDepartment,
                                      decoration: InputDecoration(
                                        hintText: 'Select department',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Software Engineering',
                                          child: Text('Software Engineering'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Computer Science',
                                          child: Text('Computer Science'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'InfoTech',
                                          child: Text('InfoTech'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Data Science',
                                          child: Text('Data Science'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Cyber Security',
                                          child: Text('Cyber Security'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedDepartment = value;
                                        });
                                      },
                                      validator: (value) => _requiredValidator(
                                        value,
                                        'Department',
                                      ),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'Programme',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    TextFormField(
                                      controller: _programmeController,
                                      decoration: InputDecoration(
                                        hintText: 'e.g. Computer Science',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      validator: (value) => _requiredValidator(
                                        value,
                                        'Programme',
                                      ),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text('Level', style: AppTextStyle.sevStyle),
                                    Gap(8 / 844 * size.height),
                                    TextFormField(
                                      controller: _levelController,
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 100',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      validator: (value) =>
                                          _requiredValidator(value, 'Level'),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'Year of Admission',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    TextFormField(
                                      controller: _yearOfAdmissionController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 2022',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      validator: (value) => _requiredValidator(
                                        value,
                                        'Year of admission',
                                      ),
                                    ),
                                    Gap(14 / 844 * size.height),
                                    Text(
                                      'Expected Graduation',
                                      style: AppTextStyle.sevStyle,
                                    ),
                                    Gap(8 / 844 * size.height),
                                    TextFormField(
                                      controller: _expectedGraduationController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 2026',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: greyColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      validator: (value) => _requiredValidator(
                                        value,
                                        'Expected graduation',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(12 / 844 * size.height),
                elevBtn(
                  size,
                  isLoading ? null : _onSignUpPressed,
                  Texts.signUpText,
                  null,
                  null,
                  isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: whiteColor,
                          ),
                        )
                      : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyle.ninStyle,
                    ),
                    TextButton(
                      onPressed: () =>
                          context.goNamed(RouteNames.signInScreenString),
                      child: Text('Log In', style: AppTextStyle.tenStyle),
                    ),
                  ],
                ),
                Gap(20 / 844 * size.height),
              ],
            ),
          ),
        );
      },
    );
  }
}
