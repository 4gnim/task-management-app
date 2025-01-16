import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/app/todo/controllers/dates/dates_provider.dart';
import 'package:task_management/app/todo/controllers/todo/todo_provider.dart';
import 'package:task_management/common/models/task_model.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/app_style.dart';
import 'package:task_management/common/widgets/custom_otln_btn.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            CustomTextField(
              controller: title,
              hintText: 'Add Title',
              hintStyle: appstyle(
                16,
                AppConst.kGreyLight,
                FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: desc,
              hintText: 'Add Description',
              hintStyle: appstyle(
                16,
                AppConst.kGreyLight,
                FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomOtlnBtn(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2025, 1, 1),
                      maxTime: DateTime(2100, 1, 1),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate == ''
                    ? 'Set Date'
                    : scheduleDate.substring(0, 10)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlnBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setStart(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.4,
                  height: 52.h,
                  color: AppConst.kLight,
                  color2: AppConst.kBlueLight,
                  text: start == '' ? 'Start Time' : start.substring(10, 16),
                ),
                CustomOtlnBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(finishTimeStateProvider.notifier)
                          .setFinish(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.4,
                  height: 52.h,
                  color: AppConst.kLight,
                  color2: AppConst.kBlueLight,
                  text: finish == '' ? 'Finish Time' : finish.substring(10, 16),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomOtlnBtn(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      desc.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      start.isNotEmpty &&
                      finish.isNotEmpty) {
                    TaskModel task = TaskModel(
                      title: title.text,
                      desc: desc.text,
                      isCompleted: 0,
                      date: scheduleDate,
                      startTime: start.substring(10, 16),
                      endTime: finish.substring(10, 16),
                      remind: 0,
                      repeat: 'yes',
                    );
                    ref.read(todoStateProvider.notifier).addItem(task);

                    ref.read(finishTimeStateProvider.notifier).setFinish('');

                    ref.read(startTimeStateProvider.notifier).setStart('');

                    ref.read(dateStateProvider.notifier).setDate('');

                    Navigator.pop(context);
                  } else {}
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: 'Submit'),
          ],
        ),
      ),
    );
  }
}
