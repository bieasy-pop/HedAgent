import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';
import 'package:intl/intl.dart';

class SendAlertScreen extends StatefulWidget {
  const SendAlertScreen({super.key, this.student});

  final EducatorStudent? student;

  @override
  State<SendAlertScreen> createState() => _SendAlertScreenState();
}

class _SendAlertScreenState extends State<SendAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  late String _audience;
  AlertStatus _status = AlertStatus.reminder;

  @override
  void initState() {
    super.initState();
    _audience = widget.student?.name ?? 'All Students';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;
    final audiences = <String>[
      'All Students',
      ...store.enrolledCourses.map((c) => c.title),
      if (widget.student != null) widget.student!.name,
    ];

    return Scaffold(
      appBar: headerWidget('assets/svgs/small_ic.svg', 'EduAgent', []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24),
                Text('Send Alert', style: AppTextStyle.twentSixStyle),
                Text(
                  'Push a notification to your students.',
                  style: AppTextStyle.elevStyle,
                ),
                Gap(24),
                DropdownButtonFormField<String>(
                  initialValue: audiences.contains(_audience)
                      ? _audience
                      : audiences.first,
                  decoration: const InputDecoration(labelText: 'Audience'),
                  items: audiences
                      .toSet()
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _audience = value);
                  },
                ),
                Gap(12),
                DropdownButtonFormField<AlertStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: 'Alert Type'),
                  items: AlertStatus.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _status = value);
                  },
                ),
                Gap(12),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Title is required'
                      : null,
                ),
                Gap(12),
                TextFormField(
                  controller: _bodyController,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Message'),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Message is required'
                      : null,
                ),
                Gap(28),
                elevBtn(size, () {
                  if (!_formKey.currentState!.validate()) return;
                  EducatorStore.instance.sendAlert(
                    SentAlert(
                      title: _titleController.text.trim(),
                      body: _bodyController.text.trim(),
                      audience: _audience,
                      status: _status,
                      time: DateFormat('MMM d, h:mm a').format(DateTime.now()),
                    ),
                  );
                  context.pop();
                }, 'Send Alert', primaryColor, null, null),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
