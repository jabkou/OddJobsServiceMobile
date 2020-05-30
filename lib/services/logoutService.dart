import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart';
import '../models/user.dart';

class Logout {
  logoutUser(User user) async{
    if(!user.isLogin()) //czy wgl potrzebne
      return;
    Response response = await get(logoutUrl, headers: user.getHeaders());
    if (response.statusCode != 200)
      throw Exception("Blad polaczenia: " + response.statusCode.toString());
    user.logout();
  }
}