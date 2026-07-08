import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/goals/data/goals_repository.dart';
import 'package:hedagent/features/goals/models/goal.dart';
import 'package:intl/intl.dart';

class GoalDetailScreen extends StatefulWidget {
  const GoalDetailScreen({super.key, required this.goalId});

  final String goalId;

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  Goal? _goal;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await UserStorageService().getToken();
      if (token == null) {
        throw GoalException('Session expired. Please log in again.');
      }
      final goal = await GoalsRepository().getGoalById(token, widget.goalId);
      if (mounted) setState(() => _goal = goal);
    } on GoalException catch (e) {
      if (mounted) setState(() => _errorMessage = e.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _errorMessage = 'Something went wrong. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: headerWidget('assets/svgs/small_ic.svg', 'EduAgent', []),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_errorMessage!, textAlign: TextAlign.center),
                    Gap(12),
                    TextButton(onPressed: _loadGoal, child: Text('Retry')),
                  ],
                ),
              ),
            )
          : _buildContent(size, _goal!),
    );
  }

  Widget _buildContent(Size size, Goal goal) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16),
            Text('Goal', style: AppTextStyle.eigStyle),
            Gap(4),
            Text(goal.description, style: AppTextStyle.twentStyle),
            if (goal.createdAt != null) ...[
              Gap(4),
              Text(
                'Added ${DateFormat('MMM d, yyyy').format(goal.createdAt!)}',
                style: AppTextStyle.nintStyle,
              ),
            ],
            if (goal.aiSummary != null && goal.aiSummary!.isNotEmpty) ...[
              Gap(20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: thirLightBlueColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 16, color: primaryColor),
                        Gap(6),
                        Text('AI RECOMMENDATION', style: AppTextStyle.eigStyle),
                      ],
                    ),
                    Gap(6),
                    Text(goal.aiSummary!, style: AppTextStyle.sevtStyle),
                  ],
                ),
              ),
            ],
            Gap(24),
            Text('Interventions', style: AppTextStyle.fourtStyle),
            Gap(12),
            if (goal.interventions.isEmpty)
              Text(
                'No interventions logged for this goal yet.',
                style: AppTextStyle.nintStyle,
              )
            else
              ...goal.interventions.map(
                (intervention) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          intervention.type ?? 'Intervention',
                          style: AppTextStyle.fourStyle,
                        ),
                        if (intervention.message != null) ...[
                          Gap(4),
                          Text(
                            intervention.message!,
                            style: AppTextStyle.nintStyle,
                          ),
                        ],
                        if (intervention.createdAt != null) ...[
                          Gap(4),
                          Text(
                            DateFormat(
                              'MMM d, yyyy',
                            ).format(intervention.createdAt!),
                            style: AppTextStyle.eigStyle,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            Gap(50),
          ],
        ),
      ),
    );
  }
}
