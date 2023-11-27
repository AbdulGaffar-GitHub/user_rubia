import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/imageConstant.dart';
import '../responsive.dart';

class BackIconWidget extends StatelessWidget {
  const BackIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: isTab(context) ? 7 : 6,
            horizontal: isTab(context) ? 7 : 7),
        decoration: BoxDecoration(
            boxShadow: [tBoxShadow],
            color: tWhite,
            borderRadius: BorderRadius.circular(7)),
        child: Center(
            child: Image.asset(
          Images.BACK_ICON,
          scale: isTab(context) ? 2.5 : 3,
        )));
  }
}
