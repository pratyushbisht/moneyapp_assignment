import 'package:flutter/material.dart';
import 'package:moneyy_app_assignment/utils/text.dart';

import '../description.dart';



class TrendingMovies  extends StatelessWidget {

  final List trending;
  const TrendingMovies({Key?key,required this.trending}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: "Top Rated", color: Colors.white, size: 20),
          SizedBox(height: 30,),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Description(
                            name: trending[index]['title']!=null
                                ?trending[index]['title']

                                :'Loading',
                            bannerurl:
                            'https://image.tmdb.org/t/p/w500' +
                                trending[index]['backdrop_path'],
                            posterurl:
                            'https://image.tmdb.org/t/p/w500' +
                                trending[index]['poster_path'],
                            description: trending[index]['overview'],
                            vote: trending[index]['vote_average']
                                ,
                            launch_on: trending[index]
                            ['release_date'],
                          )));},
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),

                    child: Column(
                      children: [
                        Container( 

                          width: 250,
                          height: 140,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500' + trending[index]['backdrop_path']
                              ),

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child:
                          modified_text
                            (text: trending[index]['title']!=null
                            ?trending[index]['title']

                             :'Loading',
                            color: Colors.white,
                            size: 15,),
                        )
                      ],
                    ),
                  ),
                );
              },


              itemCount: trending.length,),
          )




        ],
      ),




    );
  }
}
