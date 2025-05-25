import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/pages/games/drag_and_drop.dart';
import 'package:kosakata_benda/presentasion/pages/games/matching_page.dart';
import 'package:kosakata_benda/presentasion/pages/vocabs/kosakata_rumah_page.dart';
import 'package:kosakata_benda/presentasion/pages/vocabs/kosakata_sekolah_page.dart';
import 'package:kosakata_benda/presentasion/pages/games/main_menu_page.dart';
import 'package:kosakata_benda/presentasion/pages/main_page.dart';
import 'package:kosakata_benda/presentasion/pages/vocabs/kosakata_menu_page.dart';
import 'package:kosakata_benda/presentasion/pages/option_page.dart';
import 'package:kosakata_benda/presentasion/pages/games/tebak_benda_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => MenuPage(),
    ),
    GetPage(name: '/menu', page: () => KosakataMenu()),
    GetPage(name: '/HomeVocab', page: () => HomeVocab()),
    GetPage(name: '/EduVocab', page: () => KosakataSekolah()),
    // GetPage(name: '/Option', page: () => Option()),
    GetPage(name: '/MainMenu', page: () => MainMenu()),
    GetPage(name: '/TebakBenda', page: () => TebakBenda()),
    GetPage(name: '/MainMenu', page: () => MainMenu()),
    GetPage(name: '/PasangHuruf', page: () => SusunHurufPage()),
    GetPage(name: '/MatchingPage', page: () => MatchingPage())
  ];
}
