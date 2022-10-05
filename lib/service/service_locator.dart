import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:saavan_app/audio_player/audio_handler.dart';
import 'package:saavan_app/audio_player/audio_manager.dart';
import 'package:saavan_app/service/playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<AudioServiceManager>(() => AudioServiceManager());
  getIt.registerLazySingleton<DemoPlaylist>(() => DemoPlaylist());
}
