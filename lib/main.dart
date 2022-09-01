import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moneyy_app_assignment/Start.dart';
import 'package:moneyy_app_assignment/utils/text.dart';
import 'package:moneyy_app_assignment/widgets/top_rated.dart';
import 'package:moneyy_app_assignment/widgets/trending.dart';
import 'package:moneyy_app_assignment/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HomePage.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,primaryColor: Colors.lightBlueAccent),
      home: Start(),

    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
   List trending_movies=[];
   List topratedmovies =[];
   List tvshows =[];
  final String apikey = '85acca6bc1fa852983a433fc11b8fb89';
  final String accesskey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWFjY2E2YmMxZmE4NTI5ODNhNDMzZmMxMWI4ZmI4OSIsInN1YiI6IjYzMGUyN2U1ZWRlMWIwMDA3ZWQ1YzU1YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.97wduO1Gpi8BCLM86EhdBhfy-fTS8t-K-pvi-zRCaqw';

  void initState() {
    super.initState();
    loadmovies();
    //this.checkAuthentification();
    this.getUser();
  }
  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /*checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Start()));
      }
    });
  }*/


  loadmovies() async{
    final tmdbWithCustomLogs = TMDB( //TMDB instance
      ApiKeys(apikey, accesskey),//ApiKeys instance with your keys,
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      )
    );



    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    print(tvresult);
  setState(() {
    trending_movies=trendingResults['results'];
    topratedmovies=topratedresult['results'];
    tvshows = tvresult['results'];
  });

  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }


  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Start()));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const modified_text(text: 'MoneyApp_Assignment',size: 15,color: Colors.white,)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.pink,),
            label: "Favorites",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later,color: Colors.blueGrey,),
            label: "Watch later",
            backgroundColor: Colors.black,
          ),
        ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
          elevation: 5


      ),

      body:
      ListView(
        children: [
          /*Container(
            child: Text(
              "Hello ${user.displayName} you are Logged in as ${user.email}",
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),*/
          TopRated(toprated: topratedmovies),
           TrendingMovies(trending: trending_movies),
          tv(TV: tvshows),
          TextButton(onPressed: signOut, child: modified_text(text: 'Sign out',color: Colors.white,size: 20,)),
        ],
      ),


    );
  }
}



