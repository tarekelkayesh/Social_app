import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login/shop_login_screen.dart';
import 'package:social_app/remote/cache_helper.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel ({
    required this .body,
    required this .image,
    required this .title
});
}

class OnBoardingScreen  extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

List <BoardingModel>boarding =[
  BoardingModel(
    image: 'assets/images/onboarding_1.jpg',
    body:  'On Board 1 Body',
      title: 'On Board 1 Title',
  ),
  BoardingModel(
    image: 'assets/images/onboarding_1.jpg',
    body:  'On Board 2 Body',
    title: 'On Board 2 Title',
  ),
  BoardingModel(
    image: 'assets/images/onboarding_1.jpg',
    body:  'On Board 3 Body',
    title: 'On Board 3 Title',
  ),

];

bool isLast =false ;

void submit () {
  CacheHelper.saveDate(key: 'onBoarding', value:true).then((value)
  {
    if(value!)
    {
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder:(context) => ShopLoginScreen(),
        ),
            (Route<dynamic>route) =>false,
      );

    }
  });
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed:()
              {
                submit();
              }
                , child:Text(
                'Skip',
              ),
            ),
          ],
        ),
    body:Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children:
        [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: boardController,
              onPageChanged: (int index)
              {
                if (index == boarding.length -1)
                {
                  setState(() {
                    isLast = true;
                  });
                }else
                {
                  setState(()
                  {
                    isLast =false;
                  });
                }
              },
              itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(height: 40.0,
          ),
          Row(
            children:
            [
              SmoothPageIndicator(
                  controller:boardController ,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count:boarding.length ,
              ),
              Spacer(),
              FloatingActionButton(onPressed:()
              {
                if(isLast)
                {
                    submit();
                }else
                {
                  boardController.nextPage(
                    duration: Duration(
                      milliseconds: 750,
                    ),
                    curve:Curves.fastLinearToSlowEaseIn ,
                  );
                }

              },
              child: Icon(Icons.arrow_forward_ios,
              ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>  Column
    (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,),
      Text(
        '${model.title} ',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,),
      Text(
        '${model.body} ',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,),


    ],
  );
}
