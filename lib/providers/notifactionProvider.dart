import 'dart:developer';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNotifactionProvider extends ChangeNotifier {
  List myFavoritesList = [];
  bool myFavoritesGetting = false;
  int favoritesLength = 0;
  int currentPage = 0;
  int totalPages = 0;
  getFavorites({context, page}) async {
    myFavoritesGetting = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // if(isInit){
    //   currentPage = 1;
    //   myFavoritesList.clear();
    // }
    var res = await UserAPI().getMyNotifaction(context, page);
    try {
      if (res['status'] == 'OK') {
        // myFavoritesList.clear();
        List details = res['details'];
        currentPage = res['pagination']['current_page'];
        totalPages = res['pagination']['total_pages'];
        myFavoritesList = myFavoritesList + details;
        details.clear();
        currentPage = currentPage + 1;
        log('current page' + currentPage.toString());
        log('total page' + totalPages.toString());
        // for(var i in details){
        //   myFavoritesList.add(i);
        // }
        myFavoritesGetting = false;
      } else {
        myFavoritesGetting = false;
      }
    } catch (e) {
      myFavoritesGetting = false;
      log(e.toString());
    }

    notifyListeners();
  }
}
