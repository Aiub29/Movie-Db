import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_db/models/movie_model.dart';
class MovieItem extends StatefulWidget {
  final Movie movie;
  final double pageNumber;
  final double index;
  MovieItem(this.movie, this.pageNumber, this.index);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> with SingleTickerProviderStateMixin {
  Animation<double> heightAnim;
  Animation<double> elevAnim;
  Animation<double> yOffsetAnim;
  Animation<double> scaleAnim;
  AnimationController controller;
  @override
  void initState() {
   controller=AnimationController(duration: Duration(seconds: 1),vsync: this);
   controller.addListener(() {
     setState(() {

     });
   });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
   heightAnim=Tween<double>(begin: 0.0,end: 150).animate(CurvedAnimation(
     parent: controller,
     curve: Interval(0.5,1.0,curve: Curves.easeInOut)
   ));
   scaleAnim=Tween<double>(begin: 0.95,end: 1.0).animate(CurvedAnimation(
     parent: controller,
     curve: Interval(0.0,0.3,curve: Curves.easeInOut)
   ));

   yOffsetAnim=Tween<double>(begin: 1.0,end: 10.0).animate(CurvedAnimation(
     parent: controller,
     curve: Interval(0.0,0.3,curve: Curves.easeInOut)
   ));

   elevAnim=Tween<double>(begin: 2.0,end: 10.0).animate(CurvedAnimation(
     parent: controller,
     curve: Interval(0.0,0.3,curve: Curves.easeInOut)
   ));
    super.didChangeDependencies();
  }

  final textWhiteStyle=TextStyle(fontSize: 18,color: Colors.white);
 bool isExpanded=false;
  @override
  Widget build(BuildContext context) {
    double diff=widget.index-widget.pageNumber;
   return Transform(
     transform: Matrix4.identity()
     ..setEntry(3,2, 0.002)
     ..rotateY(-pi/4*diff),
     alignment:diff> 0 ? FractionalOffset.centerLeft:FractionalOffset.centerRight,

     child: CustomScrollView(
       slivers: [SliverAppBar(
         pinned: true,
         floating: true,
         expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.movie.name),
          background: Image.asset(widget.movie.image,width: double.infinity,height: 200,fit: BoxFit.cover,),
        ),
       ),
       SliverList(
         delegate: SliverChildListDelegate([
           Stack(
             children: [
               Card(
                 color: Colors.deepPurple.withOpacity(0.9),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10,top: 100,bottom: 10),
                   child: Text(widget.movie.description,style: TextStyle(fontSize: 18,color: Colors.white),),
                 ),
               ),
               Transform.scale(
                 scale: scaleAnim.value,
                 child: Container(
                   margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.deepPurple.shade900,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black,
                         blurRadius: elevAnim.value,
                         spreadRadius: 1,
                         offset: Offset(0,yOffsetAnim.value),
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       ListTile(
                         title: Text(widget.movie.name,style: textWhiteStyle,),
                         subtitle: Text(widget.movie.category,style: textWhiteStyle,),
                         trailing: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Icon(Icons.star,color: Colors.white,),
                             Text('${widget.movie.rating}',style: textWhiteStyle,)
                           ],
                         ),
                         onTap: (){
                           if(isExpanded){
                             controller.reverse();
                             }
                           else{
                             controller.forward();
                           }
                           setState(() {
                             isExpanded= !isExpanded;

                           });
                         },
                       ),
                       ClipRRect(
                         borderRadius: BorderRadius.only(
                           bottomLeft: Radius.circular(10),
                           bottomRight: Radius.circular(10),
                         ),
                         child: Container(
                           decoration: BoxDecoration(
                             gradient: LinearGradient(
                               colors: [Colors.deepPurple.shade900,Colors.deepPurple.shade400],
                               begin: Alignment.topCenter,
                               end: Alignment.bottomCenter,
                             ),
                           ),
                           alignment: Alignment.center,
                           height: heightAnim.value,
                           child: SizedBox(
                             width: MediaQuery.of(context).size.width/1.5,
                             child: ListView(
                               children: [
                                 Text('Directed by : ${widget.movie.director}',style: textWhiteStyle,),
                                 Text('Produced by : ${widget.movie.producer}',style: textWhiteStyle,),
                                 Text('Production : ${widget.movie.production}',style: textWhiteStyle,),
                                 Text('Laguage : ${widget.movie.language}',style: textWhiteStyle,),
                                 Text('Running Time : ${widget.movie.runningTime}',style: textWhiteStyle,),
                                 Text('Country: ${widget.movie.country}',style: textWhiteStyle,),
                                 Text('Budget: ${widget.movie.budget}',style: textWhiteStyle,),
                                 Text('Box Office: ${widget.movie.boxOffice}',style: textWhiteStyle,),
                               ],
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ],
           )
         ]),
       )
       ],
     ),
   );

}
}
