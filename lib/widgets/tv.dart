import 'package:flutter/material.dart';
import 'package:moneyy_app_assignment/utils/text.dart';

import '../description.dart';



class tv  extends StatelessWidget {

  final List TV;
  const tv({Key?key,required this.TV}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: "Popular TV shows", color: Colors.white, size: 20),
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
                              name: "TV SHOW",
                              bannerurl:
                              'https://image.tmdb.org/t/p/w500' +
                                  TV[index]['backdrop_path'],
                              posterurl:
                              'https://image.tmdb.org/t/p/w500' +
                                  TV[index]['poster_path'],
                              description: TV[index]['overview'],
                              vote: TV[index]['vote_average']
                              ,
                              launch_on: TV[index]
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
                                  'https://image.tmdb.org/t/p/w500' + TV[index]['backdrop_path']
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child:
                          modified_text
                            (text: TV[index]['original_name'],
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


              itemCount: TV.length,),
          )




        ],
      ),




    );
  }
}