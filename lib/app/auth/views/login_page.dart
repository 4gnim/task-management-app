import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management/app/auth/views/otp_page.dart';
import 'package:task_management/common/utils/constants.dart';
import 'package:task_management/common/widgets/app_style.dart';
import 'package:task_management/common/widgets/custom_otln_btn.dart';
import 'package:task_management/common/widgets/custom_text_field.dart';
import 'package:task_management/common/widgets/reusable_text.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  Country country = Country(
      phoneCode: '1',
      countryCode: 'US',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'USA',
      example: 'USA',
      displayName: 'United States',
      displayNameNoCountryCode: 'US',
      e164Key: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  'assets/images/todo.png',
                  width: 300,
                )),
            SizedBox(height: 20.h),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w),
              child: ReusableText(
                  text: 'Please enter you phone number',
                  style: appstyle(17, AppConst.kLight, FontWeight.w500)),
            ),
            SizedBox(height: 20.h),
            Center(
              child: CustomTextField(
                controller: phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                              backgroundColor: AppConst.kLight,
                              bottomSheetHeight: AppConst.kHeight * 0.6,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConst.kRadius),
                                  topRight: Radius.circular(AppConst.kRadius))),
                          onSelect: (code) {
                            setState(() {});
                          });
                    },
                    child: ReusableText(
                        text: '${country.flagEmoji} + ${country.phoneCode}',
                        style: appstyle(18, AppConst.kBkDart, FontWeight.bold)),
                  ),
                ),
                keyboardType: TextInputType.number,
                hintText: 'Enter phone number',
                hintStyle: appstyle(16, AppConst.kBkDart, FontWeight.w600),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOtlnBtn(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpPage()));
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHeight * 0.075,
                  color: AppConst.kBkDart,
                  color2: AppConst.kLight,
                  text: 'Send Code'),
            ),
          ],
        ),
      )),
    );
  }
}
