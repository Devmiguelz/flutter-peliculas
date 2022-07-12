import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:peliculas/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
		debugShowCheckedModeBanner: false,
		title: 'Películas',
		initialRoute: 'home',
		routes: {
			'home': (BuildContext context) => const HomeScreen(),
			'details': (BuildContext context) => const DetailsScreen(),
		},
		theme: AppTheme.lightTheme);
	}
}
