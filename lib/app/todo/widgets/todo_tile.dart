import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/app_style.dart';
import 'package:task_management/common/widgets/reusable_text.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      this.color,
      this.title,
      this.description,
      this.start,
      this.end,
      this.editWidget,
      this.delete,
      this.switcher});

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.kWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                        color: color ?? AppConst.kRed,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppConst.kRadius)),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConst.kWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? 'Title of Todo',
                              style: appstyle(
                                  18, AppConst.kLight, FontWeight.bold),
                            ),
                            SizedBox(height: 3.h),
                            ReusableText(
                              text: description ?? 'Description of Todo',
                              style: appstyle(
                                  12, AppConst.kLight, FontWeight.bold),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3, color: AppConst.kGreyDk),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppConst.kRadius)),
                                    color: AppConst.kBkDart,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                        text: "$start | $end",
                                        style: appstyle(12, AppConst.kLight,
                                            FontWeight.normal)),
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Row(
                                  children: [
                                    SizedBox(child: editWidget),
                                    SizedBox(width: 20.w),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    ),
                                    Container(
                                      child: Text('halo'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(child: switcher),
              ],
            ),
          )
        ],
      ),
    );
  }
}
