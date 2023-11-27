// import 'package:base_project_flutter/Models/NearByReastaurantsModel.dart'
//     as SearchBar;

import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';

import 'package:base_project_flutter/globalWidgets/customTextFiled.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/homePage.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../responsive.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, this.boolSearch}) : super(key: key);
  final boolSearch;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  String _value = '';
  void _onChanged(String value) {
    setState(() => _value = '${value}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, HomePage());
      },
      child: Scaffold(
        backgroundColor: tBackground,
        appBar: AppBar(
          backgroundColor: tWhite,
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: new Image.asset(
                Images.BACK_ICON,
                // color: tBlack,
                // width: isTab(context) ? 20 : 10,
                scale: 4,
              ),
              onPressed: () {
                Twl.forceNavigateTo(
                    context,
                    BottomNavigation(
                      tabIndexId: 0,
                    ));
                // widget.boolSearch == false
                //     ? Twl.navigateBack(context):Twl.forceNavigateTo(
                //         context,
                //         BottomNavigation(
                //           tabIndexId: 0,
                //         ));
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          centerTitle: true,
          title: Text(
            "Search by Category",
            style: TextStyle(
                color: tBlack,
                fontSize: isTab(context) ? 10.sp : 15.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              color: tWhite,
              padding: EdgeInsets.all(10),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile number cant be empty';
                    } else if (value.length != 10 && value.length < 10) {
                      return 'Mobile number must be 10 digits';
                    } else {
                      return null;
                    }
                  },
                  // controller: _userNameController,
                  //_phoneNumberController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: isTab(context) ? 10.sp : 14.sp),
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                    // prefix: Text('+91 ',style: TextStyle(color: tBlack),),
                    contentPadding: EdgeInsets.only(top: 10),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: new Image.asset(
                              Images.SEARCHICON,
                              width: 20,
                            ) // icon is 48px widget.
                            ),
                      ],
                    ),
                    hintStyle: TextStyle(
                        fontSize: isTab(context) ? 10.sp : 14.sp, color: tGray),
                    hintText: 'Search',
                    fillColor: Colors.white,
                    filled: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tlightGray, width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ),
            // Expanded(
            //   child: FutureBuilder<SearchBar.NearByRestaurantModel>(
            //       // future: StoreApi().getSearchbyRestaurents(context, "0", _value),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState != ConnectionState.done) {
            //           return SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 VideoShimmer(
            //                   padding: EdgeInsets.only(left: 5, right: 5),
            //                 ),
            //                 SizedBox(height: 10),
            //                 VideoShimmer(
            //                   padding: EdgeInsets.only(left: 5, right: 5),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }
            //         if (snapshot.hasError) {
            //           print(snapshot.hasError.toString());
            //         }
            //         if (snapshot.hasData) {
            //           return Padding(
            //             padding: EdgeInsets.only(top: 10),
            //             child: SearchPagination(
            //               value: _value,
            //               searchList: snapshot.data,
            //             ),
            //           );
            //         } else {
            //           return Align(
            //               alignment: Alignment.center,
            //               child: Text('Search for Relavent KeyWord'));
            //         }
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}

class SearchPagination extends StatefulWidget {
  SearchPagination({Key? key, this.searchList, this.value}) : super(key: key);
  final searchList;
  final value;
  @override
  State<SearchPagination> createState() => _SearchPaginationState();
}

class _SearchPaginationState extends State<SearchPagination> {
  ScrollController scrollController = new ScrollController();
  int page = 0;
  // late List<SearchBar.Detail> mySearchList;
  late double scrollPosition;

  // _scrollListener() {
  //   if (scrollController.position.maxScrollExtent > scrollController.offset &&
  //       scrollController.position.maxScrollExtent - scrollController.offset <=
  //           95) {
  //     print('End Scroll');
  //     page = (page + 1);
  //     StoreApi()
  //         .getSearchbyRestaurents(context, page.toString(), widget.value)
  //         .then((val) {
  //       // currentPage = currentPage++;
  //       if (val.details != null) {
  //         setState(() {
  //           // currentPage = currentPage + 1;
  //           mySearchList.addAll(val.details);
  //         });
  //       } else {
  //         return Center(
  //           child: Text('End of data'),
  //         );
  //       }
  //     });
  //   }
  // }

  void initState() {
    scrollController = ScrollController();
    // mySearchList = widget.searchList.details;

    // scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        // itemCount: mySearchList.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          // var nearbyRes = mySearchList[index];
          return GestureDetector(
              // onTap: () async {
              //   await Twl.navigateTo(context,
              //       RestaurantView(nearbyResId: nearbyRes.id.toString()));
              // },
              child: Padding(
            padding: EdgeInsets.only(top: 8),
            // child: RestaurantCard(nearbyRes: nearbyRes),
          ));
        });
  }
}
