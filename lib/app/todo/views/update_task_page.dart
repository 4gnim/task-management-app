import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/app/todo/controllers/dates/dates_provider.dart';
import 'package:task_management/app/todo/controllers/todo/todo_provider.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/app_style.dart';
import 'package:task_management/common/widgets/custom_otln_btn.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class UpdateTaskPage extends ConsumerStatefulWidget {
  const UpdateTaskPage({super.key, required this.id});

  final int id;

  @override
  ConsumerState<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends ConsumerState<UpdateTaskPage> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);

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
                    ref.read(todoStateProvider.notifier).updateItem(
                        widget.id,
                        title.text,
                        desc.text,
                        0,
                        scheduleDate,
                        start.substring(10, 16),
                        finish.substring(10, 16));

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
