import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/route/app_router_names.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible = false;

  final TextEditingController _dateController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                height: 0.7 * size.height,
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
                        'Create your account',
                        style: AppTextStyle.twentSixStyle,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Join the network of empathetic intelligence in education.',
                        style: AppTextStyle.nintStyle,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(24 / 844 * size.height),
                              Text(
                                Texts.emailLabelText,
                                style: AppTextStyle.sevStyle,
                              ),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'mail@gmail.com',
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: greyColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text(
                                Texts.passwordLabelText,
                                style: AppTextStyle.sevStyle,
                              ),
                              Gap(8 / 844 * size.height),
                              TextField(
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  hintText: '***********',
                                  prefixIcon: const Icon(
                                    Icons.lock_outlined,
                                    color: greyColor,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(
                                      isVisible
                                          ? Icons.visibility_sharp
                                          : Icons.visibility_off_outlined,
                                      color: greyColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text(
                                'Confirm Password',
                                style: AppTextStyle.sevStyle,
                              ),
                              Gap(8 / 844 * size.height),
                              TextField(
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  hintText: '***********',
                                  prefixIcon: const Icon(
                                    Icons.lock_outlined,
                                    color: greyColor,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(
                                      isVisible
                                          ? Icons.visibility_sharp
                                          : Icons.visibility_off_outlined,
                                      color: greyColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('First Name', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'John',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('Last Name', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Doe',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('Matric No', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your matric number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('College', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your college',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('Department', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your department',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('College', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your college',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                              Gap(14 / 844 * size.height),
                              Text('Phone No', style: AppTextStyle.sevStyle),
                              Gap(8 / 844 * size.height),
                              IntlPhoneField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: greyColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                                initialCountryCode: 'NG',
                              ),
                              Gap(24 / 844 * size.height),
                              TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                onTap: _pickDate,
                                decoration: const InputDecoration(
                                  labelText: 'Select Date',
                                  hintText: 'Choose a date',
                                  suffixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              // elevBtn(
                              //   size,
                              //   () => context.goNamed(RouteNames.homeString),
                              //   Texts.signUpText,
                              //   null,
                              //   null,
                              // ),
                            ],
                          ),
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
    );
  }
}
