import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../responsive.dart';

class SpecialCard1 extends StatefulWidget {
  const SpecialCard1({Key? key}) : super(key: key);

  @override
  State<SpecialCard1> createState() => _SpecialCard1State();
}

class _SpecialCard1State extends State<SpecialCard1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Claim_your_Special'.tr,
            style: TextStyle(
                fontSize: isDesktop(context)
                    ? 3.sp
                    : isTab(context)
                        ? 8.sp
                        : 14.sp,
                fontWeight: FontWeight.w700,
                color: tDarkNavyblue),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  // var coupon =
                  //     snapshot.data!.details[index];

                  return Image.asset(Images.CARD1);
                }),
          ),
        )
      ],
    );
  }
}
