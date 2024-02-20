import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPrefs {
  SharedPreferences? _sharedPrefs;

  Future<SharedPreferences> getPrefs() async {
    return _sharedPrefs ??= await SharedPreferences.getInstance();

    // return _sharedPrefs!;
  }
}
