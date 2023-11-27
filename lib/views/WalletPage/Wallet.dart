import 'package:base_project_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../api_services/userApi.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';
import 'components/TransactionDetailsWidget.dart';
import 'components/WalletCardWidget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, this.selectedType}) : super(key: key);

  @override
  final selectedType;
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  var checkDetails;
  checkWalletApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      if (mounted) {
        setState(() {
          checkDetails = check['detail'];
          print(checkDetails);
        });
      }
    }
  }

  @override
  void initState() {
    checkWalletApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: tappbarclr,
        title: Text(
          'wallet'.tr,
          style: GoogleFonts.mulish(
            color: tDarkNavyblue,
            fontSize: isTab(context) ? 10.sp : 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: checkDetails == null
          ? SpinKitThreeBounce(
              color: tPrimaryColor,
              size: 20.0,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  WalletCardWidget(),
                  TransactionDetailsWidget(
                    selectedType: widget.selectedType,
                  )
                ],
              ),
            ),
    );
  }
}
