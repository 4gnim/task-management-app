import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/app/todo/controllers/todo/todo_provider.dart';
import 'package:task_management/app/todo/views/add_task_page.dart';
import 'package:task_management/app/todo/widgets/completed_task.dart';
import 'package:task_management/app/todo/widgets/day_after_tomorrow.dart';
import 'package:task_management/app/todo/widgets/today_task.dart';
import 'package:task_management/app/todo/widgets/tomorrow_list.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/app_style.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:task_management/common/widgets/reusable_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: 'Dashboard',
                        style: appstyle(18, AppConst.kLight, FontWeight.bold)),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                          color: AppConst.kLight,
                          borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTaskPage()));
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppConst.kBkDart,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: search,
                hintText: 'Search',
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppConst.kGreyLight,
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 25.h),
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: AppConst.kLight,
                ),
                SizedBox(width: 10.w),
                ReusableText(
                    text: "Today's Task",
                    style: appstyle(18, AppConst.kLight, FontWeight.bold)),
              ],
            ),
            SizedBox(height: 25.h),
            Container(
              decoration: BoxDecoration(
                color: AppConst.kLight,
                borderRadius:
                    BorderRadius.all(Radius.circular(AppConst.kRadius)),
              ),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius)),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  labelStyle:
                      appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                  unselectedLabelColor: AppConst.kLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: 'Pending',
                            style:
                                appstyle(16, AppConst.kBkDart, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: 'Completed',
                            style:
                                appstyle(16, AppConst.kBkDart, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: AppConst.kHeight * 0.3,
              width: AppConst.kWidth,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppConst.kRadius)),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      color: AppConst.kBkLight,
                      height: AppConst.kHeight * 0.3,
                      child: const TodayTask(),
                    ),
                    Container(
                      color: AppConst.kBkLight,
                      height: AppConst.kHeight * 0.3,
                      child: const CompletedTask(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const TomorrowList(),
            SizedBox(height: 20.h),
            const DayAfterTomorrow(),
          ],
        ),
      )),
    );
  }
}
