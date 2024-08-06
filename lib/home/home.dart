import 'package:flutter/material.dart';
import 'package:kleber_bank/main.dart';
import 'package:kleber_bank/utils/app_colors.dart';
import 'package:kleber_bank/utils/app_styles.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: rSize * 0.015, vertical: rSize * 0.02),
        children: [
          Text(
            ' Popular',
            style: AppStyles.c3C496CW500S18.copyWith(fontSize: AppStyles.px20),
          ),
          SizedBox(
            height: rSize * 0.23,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(rSize * 0.005),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/login_bg.jpg',
                                height: rSize * 0.15,
                                width: rSize * 0.25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(horizontal: rSize * 0.005, vertical: 1),
                                  child: Text(
                                    '12-12-2024',
                                    style: AppStyles.c656262W200S14.copyWith(fontWeight: FontWeight.w400, fontSize: AppStyles.px12),
                                  )),
                            )
                          ],
                        ),
                        Container(
                            width: rSize * 0.25,
                            margin: EdgeInsets.only(top: rSize * 0.005),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'The 2011 London riots prepared Sta rmer for stopping unrest but tackling',
                              style: AppStyles.c656262W200S14,
                              maxLines: 2,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: rSize*0.02,),
          Text(
            ' Recommended',
            style: AppStyles.c3C496CW500S18.copyWith(fontSize: AppStyles.px20),
          ),
          SizedBox(height: rSize*0.02,),
          Container(
            height: rSize*0.55,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: rSize*0.55,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: rSize*0.5,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          alignment: Alignment.center,
                          child: Image.asset('assets/login_bg.jpg',fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: rSize*0.4,
                          child: Card(
                            margin: EdgeInsets.symmetric(horizontal: rSize*0.02),
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(rSize*0.015),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('AI Generation',style: AppStyles.c656262W400S20,),
                                  SizedBox(height: rSize*0.01,),
                                  Text('The 2011 London riots prepared Sta rmer for stopping unrest but tackling',style: AppStyles.c656262W200S14,overflow: TextOverflow.ellipsis,maxLines: 2,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.text}, index: $index");
              },
              upSwipeAllowed: true,
              fillSpace: true,
            ),
          ),
          SizedBox(height: rSize*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              swipeIcon('assets/swipe_left.png','Swipe left to like'),
              swipeIcon('assets/swipe_right.png','Swipe right to dislike'),
            ],
          )

        ],
      ),
    );
  }

  Widget swipeIcon(String img, String text) {
    return Column(
      children: [
        Container(
          height: rSize*0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.kTextFieldInput,width: 1)
                    ),
                    child: Image.asset(img,scale: 15,color: AppColors.kTextFieldInput)),
        Text(text),
      ],
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({this.text='', this.color=Colors.white});
}
