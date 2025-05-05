import 'package:get/get.dart';
import 'package:kosakata_benda/core/api/vocab_api.dart';
import 'package:kosakata_benda/data/models/vocab_model.dart';

class VocabController extends GetxController {
  var vocabs = <Vocab>[].obs;
  var rumahVocabs = <Vocab>[].obs;
  var sekolahVocabs = <Vocab>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadVocabs();
  }

  void loadVocabs() async {
    isLoading.value = true;
    try {
      final allVocabs = await VocabApi.fetchVocabs();
      vocabs.value = allVocabs;
      rumahVocabs.value = allVocabs.where((e) => e.category.toLowerCase() == 'rumah').toList();
      sekolahVocabs.value = allVocabs.where((e) => e.category.toLowerCase() == 'sekolah').toList();
    } catch (e) {
      print('Error load vocab: $e');
    }
    isLoading.value = false;
  }
}
