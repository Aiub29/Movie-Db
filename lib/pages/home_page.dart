import 'package:flutter/material.dart';
import 'package:movie_db/temp_db/db.dart';
import 'package:movie_db/widgets/movie_item.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  double pageNumber=0.0;

  @override
  void initState() {
    pageController=PageController(
      initialPage: 0,
      viewportFraction: 1
    );
    pageController.addListener(() {
     setState(() {
       pageNumber=pageController.page;
     });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Opacity(opacity: 0.5,
                child: Image.asset('images/spotlight2.jpg',width: double.infinity,height: double.infinity,fit: BoxFit.cover,)),
            PageView.builder(
              itemBuilder:(context,index)=>MovieItem(movies[index],pageNumber,index.toDouble()),
            controller: pageController,
              itemCount: movies.length,
            ),

          ],
        ),

      ),
    );








  }
}
