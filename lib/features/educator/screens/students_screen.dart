import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';
import 'package:hedagent/features/educator/widgets/student_tile_widget.dart';
import 'package:hedagent/route/app_router_names.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _filter = 'All';

  static const List<String> _filters = ['All', 'At Risk', 'Watch', 'On Track'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<EducatorStudent> _visibleStudents(List<EducatorStudent> students) {
    return students.where((student) {
      final matchesFilter = _filter == 'All' || student.riskLabel == _filter;
      final matchesQuery =
          _query.isEmpty ||
          student.name.toLowerCase().contains(_query.toLowerCase()) ||
          student.course.toLowerCase().contains(_query.toLowerCase());
      return matchesFilter && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () => context.pushNamed(RouteNames.sendAlertScreenString),
          icon: const Icon(Icons.notifications_none_outlined),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => context.pushNamed(RouteNames.addStudentScreenString),
        icon: const Icon(Icons.person_add_alt_1, color: whiteColor),
        label: Text('Add Student', style: AppTextStyle.fivStyle),
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final visible = _visibleStudents(store.students);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32 / 844 * size.height),
                  Text('Students', style: AppTextStyle.twentSixStyle),
                  Text(
                    'View and manage the students across your courses.',
                    style: AppTextStyle.elevStyle,
                  ),
                  Gap(20 / 844 * size.height),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Search by name or course',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Gap(12 / 844 * size.height),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (context, index) => const Gap(8),
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final selected = filter == _filter;
                        return ChoiceChip(
                          label: Text(filter),
                          selected: selected,
                          selectedColor: primaryColor,
                          labelStyle: AppTextStyle.tenStyle.copyWith(
                            color: selected ? whiteColor : primaryColor,
                          ),
                          backgroundColor: fourLightBlueColor,
                          onSelected: (_) => setState(() => _filter = filter),
                        );
                      },
                    ),
                  ),
                  Gap(20 / 844 * size.height),
                  if (visible.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No students match your search.',
                        style: AppTextStyle.nintStyle,
                      ),
                    )
                  else
                    ...visible.map(
                      (student) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: studentTileWidget(
                          size: size,
                          student: student,
                          onTap: () => context.pushNamed(
                            RouteNames.studentDetailScreenString,
                            extra: student,
                          ),
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
