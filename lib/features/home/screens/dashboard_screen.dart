import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/goals/data/goals_repository.dart';
import 'package:hedagent/features/goals/models/goal.dart';
import 'package:hedagent/features/goals/widgets/goal_card_widget.dart';
import 'package:hedagent/features/messages/widgets/chat_container_widget.dart';
import 'package:hedagent/route/app_router_names.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key, this.onSeeMessages});

  /// Jumps to the Messages tab in the parent bottom-nav shell. Left null
  /// when this screen is hosted somewhere without that shell.
  final VoidCallback? onSeeMessages;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Goal> _goals = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await UserStorageService().getToken();
      if (token == null) {
        throw GoalException('Session expired. Please log in again.');
      }
      final goals = await GoalsRepository().getGoals(token);
      if (mounted) setState(() => _goals = goals);
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

  void _showAddGoalSheet() {
    final descriptionController = TextEditingController();
    bool isSubmitting = false;
    String? sheetError;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            Future<void> submit() async {
              final description = descriptionController.text.trim();
              if (description.isEmpty) return;

              setSheetState(() {
                isSubmitting = true;
                sheetError = null;
              });

              try {
                final token = await UserStorageService().getToken();
                if (token == null) {
                  throw GoalException('Session expired. Please log in again.');
                }
                final goal = await GoalsRepository().createGoal(
                  token,
                  description,
                );
                if (!mounted) return;
                setState(() => _goals = [goal, ..._goals]);
                Navigator.of(sheetContext).pop();
              } on GoalException catch (e) {
                setSheetState(() => sheetError = e.message);
              } catch (_) {
                setSheetState(
                  () => sheetError = 'Something went wrong. Please try again.',
                );
              } finally {
                setSheetState(() => isSubmitting = false);
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New Goal', style: AppTextStyle.fourtStyle),
                  Gap(6),
                  Text(
                    'What do you want to achieve? Your AI agent will track progress and suggest next steps.',
                    style: AppTextStyle.nintStyle,
                  ),
                  Gap(16),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Goal description',
                      hintText: 'e.g. Raise my Physics grade to an A',
                    ),
                  ),
                  if (sheetError != null) ...[
                    Gap(8),
                    Text(
                      sheetError!,
                      style: AppTextStyle.sevStyle.copyWith(color: redColor),
                    ),
                  ],
                  Gap(20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isSubmitting ? null : submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: whiteColor,
                              ),
                            )
                          : Text('Add Goal', style: AppTextStyle.fivStyle),
                    ),
                  ),
                ],
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
    final goalsWithRecommendations = _goals
        .where((g) => g.aiSummary != null && g.aiSummary!.isNotEmpty)
        .toList();
    final interventionCount = _goals.fold<int>(
      0,
      (sum, g) => sum + g.interventions.length,
    );

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: _showAddGoalSheet,
        icon: const Icon(Icons.add, color: whiteColor),
        label: Text('Add Goal', style: AppTextStyle.fivStyle),
      ),
      body: RefreshIndicator(
        onRefresh: _loadGoals,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(32 / 844 * size.height),
                Text('Your Dashboard', style: AppTextStyle.twentStyle),
                Text(
                  'Track your goals, interventions, and AI guidance in one place.',
                  style: AppTextStyle.nintStyle,
                ),
                Gap(24 / 844 * size.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _summaryStat(size, 'Goals', '${_goals.length}'),
                    _summaryStat(
                      size,
                      'Interventions',
                      '$interventionCount',
                    ),
                    _summaryStat(
                      size,
                      'AI Tips',
                      '${goalsWithRecommendations.length}',
                    ),
                  ],
                ),
                Gap(28 / 844 * size.height),
                Text('Your Goals', style: AppTextStyle.fourtStyle),
                Gap(12 / 844 * size.height),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_errorMessage!, style: AppTextStyle.nintStyle),
                        TextButton(
                          onPressed: _loadGoals,
                          child: Text('Retry', style: AppTextStyle.tenStyle),
                        ),
                      ],
                    ),
                  )
                else if (_goals.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'You haven\'t added any goals yet. Tap "Add Goal" to get started.',
                      style: AppTextStyle.nintStyle,
                    ),
                  )
                else
                  ..._goals.map(
                    (goal) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: goalCardWidget(
                        size: size,
                        goal: goal,
                        onTap: () => context.pushNamed(
                          RouteNames.goalDetailScreenString,
                          extra: goal.id,
                        ),
                      ),
                    ),
                  ),
                Gap(28 / 844 * size.height),
                Text('AI Recommendations', style: AppTextStyle.fourtStyle),
                Gap(12 / 844 * size.height),
                if (goalsWithRecommendations.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'No recommendations yet. Add a goal to get personalized AI guidance.',
                      style: AppTextStyle.nintStyle,
                    ),
                  )
                else
                  ...goalsWithRecommendations.map(
                    (goal) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: thirLightBlueColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 16,
                              color: primaryColor,
                            ),
                            Gap(8),
                            Expanded(
                              child: Text(
                                goal.aiSummary!,
                                style: AppTextStyle.sevtStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Gap(28 / 844 * size.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Messages from Educators',
                      style: AppTextStyle.fourtStyle,
                    ),
                    TextButton(
                      onPressed: widget.onSeeMessages,
                      child: Text('See All', style: AppTextStyle.tenStyle),
                    ),
                  ],
                ),
                Gap(12 / 844 * size.height),
                chatContainerWidget(
                  size: size,
                  receiver: 'Dr. Sarah Oni',
                  time: '12:45 PM',
                  body:
                      'Your thesis proposal looks promising. I\'ve left some notes on the draft.',
                  area: 'Advanced Physics',
                  isOnline: true,
                  isRead: false,
                ),
                Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryStat(Size size, String label, String value) {
    return Container(
      width: 110 / 390 * size.width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTextStyle.fourtStyle),
          Text(label, style: AppTextStyle.eigStyle),
        ],
      ),
    );
  }
}
