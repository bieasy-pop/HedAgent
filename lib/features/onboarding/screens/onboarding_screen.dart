import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/features/onboarding/widgets/onboarding_widget.dart';
import 'package:hedagent/route/app_router_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  List<String> titles = [
    Texts.firstOnboardingBodyText,
    Texts.secondOnboardingBodyText,
    Texts.thirdOnboardingBodyText,
  ];
  List<String> subtitles = [
    Texts.firstOnboardingSubtitleText,
    Texts.secondOnboardingSubtitleText,
    Texts.thirdOnboardingSubtitleText,
  ];
  List<String> firstPoints = [
    Texts.firstOnboardingPointText,
    Texts.thirdOnboardingPointText,
    Texts.firstOnboardingPointText,
  ];
  List<String> secondPoints = [
    Texts.secondOnboardingPointText,
    Texts.fourthOnboardingPointText,
    Texts.secondOnboardingPointText,
  ];
  List<Widget> firstPointIcons = [
    SvgPicture.asset(ImagePath.realTimeIconPath),
    SvgPicture.asset(ImagePath.gradeIconPath),
    SvgPicture.asset(ImagePath.realTimeIconPath),
  ];
  List<Widget> secondPointIcons = [
    SvgPicture.asset(ImagePath.resourceIconPath),
    SvgPicture.asset(ImagePath.warningIconPath),
    SvgPicture.asset(ImagePath.resourceIconPath),
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svgs/small_ic.svg'),
            Gap(25),
            Text(Texts.appNameText, style: AppTextStyle.firStyle),
          ],
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
            child: Column(
              children: [
                onboardingWidget(
                  context: context,
                  size: size,
                  pageIcon: Image.asset(
                    ImagePath.onboardingIconPath,
                    height: 192 / 884 * size.height,
                    width: 192 / 390 * size.width,
                  ),
                  text: titles[index],
                  subtitle: subtitles[index],
                  firstPoint: firstPoints[index],
                  firstPointIcon: firstPointIcons[index],
                  secondPointIcon: secondPointIcons[index],
                  secondPoint: secondPoints[index],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 0
                        ? validOnboardingProgresswidget()
                        : onboardingProgresswidget(),
                    Gap(8),
                    index == 1
                        ? validOnboardingProgresswidget()
                        : onboardingProgresswidget(),
                    Gap(8),
                    index == 2
                        ? validOnboardingProgresswidget()
                        : onboardingProgresswidget(),
                  ],
                ),
                Gap(24 / 844 * size.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: Text(Texts.skipText)),
                    index == 2
                        ? ElevatedButton(
                            onPressed: () =>
                                context.goNamed(RouteNames.signInScreenString),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              Texts.getStartedText,
                              style: AppTextStyle.fivStyle,
                            ),
                          )
                        : TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward),
                            label: Text(Texts.swipeExploreText),
                          ),
                  ],
                ),
                Gap(30 / 844 * size.height),
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget onboardingProgresswidget() {
  return Container(
    height: 8,
    width: 16,
    decoration: BoxDecoration(color: greyColor, shape: BoxShape.circle),
  );
}

Widget validOnboardingProgresswidget() {
  return Container(
    width: 32,
    height: 8,
    decoration: BoxDecoration(
      color: primaryColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
