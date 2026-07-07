import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/mock_data.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  void _openComposeSheet() {
    final titleController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String target = 'All students';
    final targets = [
      'All students',
      ...EducatorMockStore.enrolledCourses.map((c) => c.code),
      ...EducatorMockStore.students.map((s) => s.name),
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Alert', style: AppTextStyle.fourtStyle),
                    const Gap(16),
                    DropdownButtonFormField<String>(
                      initialValue: target,
                      decoration: const InputDecoration(labelText: 'Send to'),
                      items: targets
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setSheetState(() => target = value ?? target);
                      },
                    ),
                    const Gap(12),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const Gap(12),
                    TextFormField(
                      controller: messageController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Message'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          setState(() {
                            EducatorMockStore.alerts.add(
                              MockAlert(
                                id: 'a${EducatorMockStore.alerts.length + 1}',
                                title: titleController.text.trim(),
                                message: messageController.text.trim(),
                                target: target,
                                sentAt: DateTime.now(),
                              ),
                            );
                          });
                          Navigator.of(sheetContext).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Alert sent to $target.')),
                          );
                        },
                        child: Text('Send', style: AppTextStyle.fivStyle),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final alerts = EducatorMockStore.alerts.reversed.toList();

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: _openComposeSheet,
          icon: const Icon(Icons.add_alert_outlined),
        ),
      ]),
      body: alerts.isEmpty
          ? Center(
              child: Text(
                'No alerts sent yet.',
                style: AppTextStyle.nintStyle,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 / 390 * size.width,
                vertical: 16,
              ),
              itemCount: alerts.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              alert.title,
                              style: AppTextStyle.fourStyle,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, HH:mm').format(alert.sentAt),
                            style: AppTextStyle.eigStyle,
                          ),
                        ],
                      ),
                      const Gap(4),
                      Text(alert.message, style: AppTextStyle.nintStyle),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: secLightBlueColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          alert.target,
                          style: AppTextStyle.twelvStyle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
