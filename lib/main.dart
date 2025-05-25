import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/components/routes.dart';
import 'package:kosakata_benda/presentasion/controllers/vocab_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(VocabController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
