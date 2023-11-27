import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/views/dummy.dart';
import 'package:base_project_flutter/views/homePage/components/paymentMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import '../../homePage/components/paymentSelection.dart';

class TermsConditionsCard extends StatefulWidget {
  const TermsConditionsCard({Key? key}) : super(key: key);

  @override
  State<TermsConditionsCard> createState() => _TermsConditionsCardState();
}

class _TermsConditionsCardState extends State<TermsConditionsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.5.w),
      decoration: BoxDecoration(
          color: tWhite,
          boxShadow: [tBackbtnBoxShadow],
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                Images.PRIVACT_POLICY,
                scale: isTab(context) ? 3 : 3.5,
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      // onTap: () {
                      //   Twl.forceNavigateTo(context, PaymentSelection());
                      // },
                      // onTap: () => launch(
                      //     "https://easygotransportservices.tawk.help/article/privacy-policy"),
                      child: Text(
                        "Privacy_Policy".tr,
                        style: TextStyle(
                            color: tDarkOrangeColor,
                            fontSize: isTab(context) ? 8.sp : 10.sp),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Image.asset(
                Images.TERMS_CONDITIONS,
                scale: isTab(context) ? 3 : 3.5,
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      // onTap: () {
                      //   Twl.forceNavigateTo(context, PqymentMethod());
                      // },
                      // onTap: () =>
                      // launch(TERMS_AND_CONDITIONS),
                      child: Text(
                        'terms_conditions'.tr,
                        style: TextStyle(
                            color: tDarkOrangeColor,
                            fontSize: isTab(context) ? 8.sp : 10.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
