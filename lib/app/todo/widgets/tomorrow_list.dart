import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/app/todo/controllers/todo/todo_provider.dart';
import 'package:task_management/app/todo/controllers/xpansion_provider.dart';
import 'package:task_management/app/todo/views/update_task_page.dart';
import 'package:task_management/app/todo/widgets/todo_tile.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/xpansion_tile.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    final color = ref.read(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();

    var tomorrowTasks =
        todos.where((element) => element.date!.contains(tomorrow));

    return XpansionTile(
        text: "Tomorrow's Task",
        text2: "Tomorrow's tasks are shown here",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? const Icon(
                  AntDesign.circledown,
                )
              : const Icon(
                  AntDesign.closecircleo,
                ),
        ),
        children: [
          for (final todo in tomorrowTasks)
            TodoTile(
              title: todo.title,
              description: todo.desc,
              color: color,
              start: todo.startTime,
              end: todo.endTime,
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
              },
              editWidget: GestureDetector(
                onTap: () {
                  titles = todo.title.toString();
                  descs = todo.desc.toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateTaskPage(
                              id: todo.id ?? 0,
                            )),
                  );
                },
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              switcher: const SizedBox.shrink(),
            ),
        ]);
  }
}
