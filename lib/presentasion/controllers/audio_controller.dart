import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioController extends GetxController {
  final player = AudioPlayer();
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    try {
      await player.setAsset('assets/audio/KidSong.mp3');
    } catch (e) {
      print("Gagal load audio: $e");
    }
  }

  void toggleSound() async {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      await player.play();
    } else {
      await player.pause();
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
