import 'package:saavan_app/ui/imports.dart';
import 'package:saavan_app/ui/search/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<AlbumInfoViewModel>(
          create: (_) => AlbumInfoViewModel(),
        ),
        ChangeNotifierProvider<SearchListViewModel>(
          create: (_) => SearchListViewModel(),
        ),
        ChangeNotifierProvider<AudioPlayerPageViewModel>(
          create: (_) => AudioPlayerPageViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Music App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomePage(),
        initialRoute: HomePage.route,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.route:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case AlbumInfoPage.route:
              return MaterialPageRoute(builder: (_) => const AlbumInfoPage());
            case AudioPlayerPage.route:
              return MaterialPageRoute(builder: (_) => const AudioPlayerPage());
            case SearchPage.route:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            default:
              throw Exception('Invalid route Name: ${settings.name}');
          }
        },
      ),
    );
  }
}
