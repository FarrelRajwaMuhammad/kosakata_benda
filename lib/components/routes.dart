import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/pages/kosakata_rumah_page.dart';
import 'package:kosakata_benda/presentasion/pages/kosakata_sekolah_page.dart';
import 'package:kosakata_benda/presentasion/pages/main_menu_page.dart';
import 'package:kosakata_benda/presentasion/pages/main_page.dart';
import 'package:kosakata_benda/presentasion/pages/kosakata_menu_page.dart';
import 'package:kosakata_benda/presentasion/pages/option_page.dart';
import 'package:kosakata_benda/presentasion/pages/tebak_benda_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => MenuPage(),
    ),
    GetPage(name: '/menu', page: () => KosakataMenu()),
    GetPage(name: '/HomeVocab', page: () => HomeVocab()),
    GetPage(name: '/EduVocab', page: () => KosakataSekolah()),
    GetPage(name: '/Option', page: () => Option()),
    GetPage(name: '/MainMenu', page: () => MainMenu()),
    GetPage(name: '/TebakBenda', page: () => TebakBenda())
  ];
}
