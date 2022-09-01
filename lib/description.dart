import 'package:flutter/material.dart';
import 'package:moneyy_app_assignment/utils/text.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl,  launch_on;
  final vote;

  Description(
      {Key? key,
        required this.name,
        required this.description,
        required this.bannerurl,
        required this.posterurl,
        required this.vote,
        required this.launch_on})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Icon heart = Icon(Icons.favorite_border);
  Icon watch = Icon(Icons.watch_later_outlined,color: Colors.blueGrey,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(left: 30),
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100.0,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: new CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 8,
                                    value: widget.vote/10,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                top: 40,
                                child: Text(widget.vote.toString(),style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,backgroundColor: Colors.black),textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                )])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: widget.name != null ? widget.name : 'Not Loaded', size: 24,color: Colors.white,)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child:
              modified_text(text: 'Releasing On - ' + widget.launch_on, size: 14,color: Colors.white,)),
          SizedBox(height: 20,),
          Row(children: [GestureDetector(
            onDoubleTap: (){setState(() {
              heart = Icon(Icons.favorite_border);
            });},
            child: ElevatedButton.icon(onPressed: (){setState(() {
              heart= Icon(Icons.favorite,color: Colors.pink,);
            });}, label: Text('Favorite'),icon: heart,),
          ),
          SizedBox(width: 20,),
            GestureDetector(
              onDoubleTap: (){
                setState(() {
                  watch = Icon(Icons.watch_later_outlined,color: Colors.blueGrey,);
                });
              },
              child: ElevatedButton.icon(onPressed:(){
                setState(() {
                  watch = Icon(Icons.watch_later,color: Colors.blue,);
                });


              } , icon: watch,label: Text("Watch Later",style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),),
            )



          ],),

          Row(
            children: [

              Container(
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: widget.description, size: 18,color: Colors.white,)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

