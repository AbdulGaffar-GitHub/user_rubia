
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
// import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sizer/sizer.dart';

import '../responsive.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.color,
    this.bottonText,
    this.onTap,
    this.borderSide,
    this.textcolor,
    this.child,
    this.borderRadius,
  }) : super(key: key);
  final color;
  final String? bottonText;
  final onTap;
  final child;
  final borderRadius;
  final borderSide;
  final textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ArgonButton(
        height: isTab(context) ? 70 : 50,
        width: 100.w,
        color: color,
        borderRadius: borderRadius,
        borderSide: borderSide,
        child: child,
        onTap: onTap,
        //  Text(
        //   bottonText!,

        //   style: TextStyle(
        //      letterSpacing: 1,
        //       color: textcolor,
        //       fontWeight: FontWeight.w700,
        //       fontSize: isTab(context) ? 10.sp : 14.sp),
        // ),
        loader: Container(
          padding: EdgeInsets.all(10),
          child: SpinKitRotatingCircle(
            color: Colors.white,
            // size: loaderWidth ,
          ),
        ),
      ),
    );
  }
}



// import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:sizer/sizer.dart';

// import '../responsive.dart';

// class Button extends StatelessWidget {
//   const Button({
//     Key? key,
//     this.color,
//     this.bottonText,
//     this.onTap,
//     this.child,
//     this.borderSide,
//     this.textcolor,
//   }) : super(key: key);
//   final color;
//   final String? bottonText;
//   final onTap;
//   final child;
//   final borderSide;
//   final textcolor;

//   @override
//   Widget build(BuildContext context) {
//     return ArgonButton(
//       height: isTab(context) ? 70 : 50,
//       width: 100.w,
//       color: color,
//       borderRadius: 4,
//       borderSide: borderSide,
//       child: child,
//       loader: Container(
//         padding: EdgeInsets.all(10),
//         child: SpinKitRotatingCircle(
//           color: Colors.white,
//           // size: loaderWidth ,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }