import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/route/app_router_names.dart';

class EducatorProfileScreen extends StatefulWidget {
  const EducatorProfileScreen({super.key});

  @override
  State<EducatorProfileScreen> createState() => _EducatorProfileScreenState();
}

class _EducatorProfileScreenState extends State<EducatorProfileScreen> {
  AuthUser? _user;

  @override
  void initState() {
    super.initState();
    UserStorageService().getUser().then((user) {
      if (mounted) setState(() => _user = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;
    final user = _user;
    final educatorProfile = user?.educatorProfile;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, []),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 / 844 * size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(36 / 844 * size.height),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: fourLightBlueColor,
                      child: Icon(Icons.person, size: 40, color: primaryColor),
                    ),
                    Gap(8),
                    Text(
                      user?.fullName ?? '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                      style: AppTextStyle.secStyle,
                    ),
                    Text(
                      educatorProfile?.designation ?? 'Educator',
                      style: AppTextStyle.elevStyle,
                    ),
                    if (educatorProfile?.department != null)
                      Text(
                        '${educatorProfile!.department} • Staff ID: ${educatorProfile.staffId ?? '-'}',
                        style: AppTextStyle.nintStyle,
                      ),
                  ],
                ),
              ),
              Gap(32 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileStat(size, 'Courses', '${store.enrolledCourseCount}'),
                  _profileStat(size, 'Students', '${store.students.length}'),
                  _profileStat(size, 'Interventions', '${store.interventionCount}'),
                ],
              ),
              Gap(32 / 844 * size.height),
              Text('Account', style: AppTextStyle.fourtStyle),
              Gap(12),
              _menuTile(
                icon: Icons.campaign_outlined,
                label: 'Send Alert',
                onTap: () => context.pushNamed(RouteNames.sendAlertScreenString),
              ),
              Gap(24),
              elevBtn(
                size,
                () async {
                  await FlutterSecureStorage().deleteAll();
                  // ignore: use_build_context_synchronously
                  context.goNamed(RouteNames.signInScreenString);
                },
                'Log Out',
                redColor,
                null,
                null,
              ),
              Gap(70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStat(Size size, String label, String value) {
    return Container(
      width: 110 / 390 * size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyle.fourtStyle),
          Text(label, style: AppTextStyle.eigStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: primaryColor),
              Gap(12),
              Expanded(child: Text(label, style: AppTextStyle.ninStyle)),
              Icon(Icons.arrow_forward_ios, size: 12, color: fourGreyColor),
            ],
          ),
        ),
      ),
    );
  }
}
