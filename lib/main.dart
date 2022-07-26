import 'package:flutter/material.dart';
import 'package:git_app/ui/album_info/album_info_page.dart';
import 'package:git_app/ui/album_info/album_info_view_model.dart';
import 'package:git_app/ui/home/home.dart';
import 'package:git_app/ui/home/home_view_model.dart';
import 'package:git_app/ui/search/search_page_view_model.dart';
import 'package:provider/provider.dart';

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
            default:
              throw Exception('Invalid route Name: ${settings.name}');
          }
        },
      ),
    );
  }
}
