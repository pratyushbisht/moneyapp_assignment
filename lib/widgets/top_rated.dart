import 'package:flutter/material.dart';
import 'package:moneyy_app_assignment/utils/text.dart';
import 'package:moneyy_app_assignment/description.dart';



class TopRated  extends StatelessWidget {

  final List toprated;
  const TopRated({Key?key,required this.toprated}) : super(key:key);
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
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                              name: toprated[index]['title']!=null
                                  ?toprated[index]['title']

                                  :'Loading',
                              bannerurl:
                              'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['backdrop_path'],
                              posterurl:
                              'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['poster_path'],
                              description: toprated[index]['overview'],
                              vote: toprated[index]['vote_average']
                              ,
                              launch_on: toprated[index]
                              ['release_date'],
                            )));



                  },
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
                                  'https://image.tmdb.org/t/p/w500' + toprated[index]['backdrop_path']
                              ),

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child:
                          modified_text
                            (text: toprated[index]['title'],
                            // ?TV[index]['orginal_name']
                            //
                            // :'Loading',
                            color: Colors.white,
                            size: 15,),
                        )
                      ],
                    ),
                  ),
                );
              },


              itemCount: toprated.length,),
          )




        ],
      ),




    );
  }
}