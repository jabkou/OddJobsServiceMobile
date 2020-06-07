import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/models/advertisementModel.dart';
import 'package:http/http.dart';

class GetAdvertisementsService {
  Future<List<Advertisement>> getPosts({workingHours, contractType, city, advertisementCategory, user}) async {
    Response res = await get(connectKeys(advertisementsURL,workingHours: workingHours, contractType: contractType, city: city, advertisementCategory: advertisementCategory, user: user));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Advertisement> posts = body
          .map(
            (dynamic item) => Advertisement.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
  String connectKeys(String url, {workingHours, contractType, city, advertisementCategory, user}){
    String newUrl;
    if(workingHours != null || contractType!=null || city!=null ||advertisementCategory!=null || user!=null){
      newUrl = url+"?";
    } else{
      return url;
    }
    if(workingHours != null && workingHours!="EMPTY"){
      if(newUrl[newUrl.length-1] != '?'){
        newUrl = newUrl + "&workingHours="+workingHours;
      }else{
        newUrl = newUrl + "workingHours="+workingHours;
      }
    }
    if(contractType != null && contractType!="EMPTY"){
      if(newUrl[newUrl.length-1] != '?'){
        newUrl = newUrl + "&contractType="+contractType;
      }else{
        newUrl = newUrl + "contractType="+contractType;
      }
    }
    if(city != null && city!="EMPTY"){
      if(newUrl[newUrl.length-1] != '?'){
        newUrl = newUrl + "&city="+city;
      }else{
        newUrl = newUrl + "city="+city;
      }
    }
    if(advertisementCategory != null && advertisementCategory!="EMPTY"){
      if(newUrl[newUrl.length-1] != '?'){
        newUrl = newUrl + "&advertisementCategory="+advertisementCategory;
      }else{
        newUrl = newUrl + "advertisementCategory="+advertisementCategory;
      }
    }
    if(user != null && user!="EMPTY"){
      if(newUrl[newUrl.length-1] != '?'){
        newUrl = newUrl + "&createdBy="+user;
      }else{
        newUrl = newUrl + "createdBy="+user;
      }
    }
    return newUrl;
  }
}
