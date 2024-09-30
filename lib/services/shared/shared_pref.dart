import 'package:aldi_test/data/user.data.dart';
import 'package:aldi_test/helper/global_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _keyUserId = 'USER-ID';

  // USER
  static loadUser() async {
    final sp = await SharedPreferences.getInstance();
    final id = sp.getInt(_keyUserId)!;
    final usrFromDB = await UserData.getData(id);
    user = usrFromDB!;
  }

  static setUserID(int userID) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(_keyUserId, userID);
  }
}
