import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../responsive.dart';

class SpecialCard extends StatefulWidget {
  const SpecialCard({Key? key}) : super(key: key);

  @override
  State<SpecialCard> createState() => _SpecialCardState();
}

class _SpecialCardState extends State<SpecialCard> {
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
          padding: EdgeInsets.only(left:12),
          child: Container(
            height: MediaQuery.of(context).size.height/5,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  // var coupon =
                  //     snapshot.data!.details[index];

                  return Image.asset(Images.CARD);
                }),
          ),
        )
      ],
    );
  }
}
