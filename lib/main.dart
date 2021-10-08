import 'package:flutter/material.dart';
import 'package:movie_app_flutter/splash.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../widgets/trending.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     brightness: Brightness.dark, primaryColor: Colors.pinkAccent),
    );
  }
}

class Home extends StatefulWidget {
  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {
  final String apikey =
      //'67af5e631dcbb4d0981b06996fcd47bc';
      '56175e661f8b62aab556114bacfa6b49';
  final String readaccesstoken =
//'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1YiI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjE3NWU2NjFmOGI2MmFhYjU1NjExNGJhY2ZhNmI0OSIsInN1YiI6IjYxNTgxNDE4NjllYjkwMDA0MjAyZDFlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Sy6ICpyyaSergw0ajreGcME8NKGFvew-truVPdMZlYA';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      print(trendingmovies);
      print(topratedresult);
      print(tv);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: ListView(
        children: [
          TV(
            tv: tv,
          ),
          Toprated(
            toprated: topratedmovies,
          ),
          TrendingMovies(
            trending: trendingmovies,
          )
        ],
      ),
    );
  }
}
