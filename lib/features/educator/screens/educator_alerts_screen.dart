import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/messages/screen/message_screen.dart' show alertContainerWidget;
import 'package:hedagent/route/app_router_names.dart';

class EducatorAlertsScreen extends StatelessWidget {
  const EducatorAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, []),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => context.pushNamed(RouteNames.sendAlertScreenString),
        icon: const Icon(Icons.campaign_outlined, color: whiteColor),
        label: Text('New Alert', style: AppTextStyle.fivStyle),
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32 / 844 * size.height),
                  Text('Alerts & Notifications', style: AppTextStyle.twentSixStyle),
                  Text(
                    'Push updates and warnings to your students.',
                    style: AppTextStyle.elevStyle,
                  ),
                  Gap(20 / 844 * size.height),
                  if (store.sentAlerts.isEmpty)
                    Text(
                      'You have not sent any alerts yet.',
                      style: AppTextStyle.nintStyle,
                    )
                  else
                    ...store.sentAlerts.map(
                      (alert) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            alertContainerWidget(
                              size: size,
                              status: alert.status,
                              title: alert.title,
                              body: alert.body,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                'To: ${alert.audience} • ${alert.time}',
                                style: AppTextStyle.eigStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Gap(90),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
