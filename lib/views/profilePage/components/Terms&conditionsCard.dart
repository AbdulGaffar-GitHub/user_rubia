import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/views/dummy.dart';
import 'package:base_project_flutter/views/homePage/components/paymentMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import '../../homePage/components/paymentSelection.dart';

class TermsConditionsCard extends StatefulWidget {
  const TermsConditionsCard({Key? key}) : super(key: key);

  @override
  State<TermsConditionsCard> createState() => _TermsConditionsCardState();
}

class _TermsConditionsCardState extends State<TermsConditionsCard> {

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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
                      onTap: () => _launchUrl(
                          Uri.parse("https://rubia.services/privacy%20and%20policy.html")),
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
                      onTap: () => _launchUrl(
                          Uri.parse("https://rubia.services/terme%20and%20conditions.html")),
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
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Image.asset(
                Images.REFUND_POLICY,
                scale: isTab(context) ? 2.7 : 3.7,
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
                      onTap: () => _launchUrl(
                          Uri.parse("https://rubia.services/RefundPolicy.html")),
                      child: Text(
                        "Cancellation & Refund Policy".tr,
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
        ],
      ),
    );
  }
}
