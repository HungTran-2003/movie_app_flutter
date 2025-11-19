import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreferences {
  AppSharePreferences._internal();
  static final AppSharePreferences _instance = AppSharePreferences._internal();
  static AppSharePreferences get instance => _instance;

  static const _key = "favorite_movies";
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
        'IdStorage chưa được init. Gọi IdStorage.instance.init() trong main()',
      );
    }
    return _prefs!;
  }

  List<int> getIds() {
    final list = prefs.getStringList(_key) ?? [];
    return list.map(int.parse).toList();
  }

  Future<void> saveIds(List<int> ids) async {
    await prefs.setStringList(_key, ids.map((e) => e.toString()).toList());
  }
}
