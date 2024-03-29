import 'package:flutter/material.dart';
import 'package:funny_test/funnyApp/content.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';



class funnyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Swipe Cards Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _jokesContent = <String>[
    'A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on. "The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now."The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."',
    'Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"',
    'The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, "I am going to eat that pussy once Jimmy leaves for school today!"',
    'A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think its either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"',
  ];


  @override
  void initState() {
    for (int i = 0; i < _jokesContent.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _jokesContent[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("This is Funny! $i"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("This is not Funny $i"),
              duration: const Duration(milliseconds: 500),
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
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
            children: [
              Image.asset('images/LOGO.png', width: 50,),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "You.\n",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      TextSpan(
                        text: "Gonna\n",
                        style: TextStyle(color: Colors.black.withOpacity(1.0)),
                      ),
                    ],
                  ),
                ),),
              const CircleAvatar(
                backgroundImage: AssetImage('images/avatar.png'),
              ),
            ]
        ),backgroundColor: Colors.white,
      ),
      body:
      SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: const Color(0xff29B363),
                width: double.infinity,
                height: 160,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "A joke a day keeps the doctor away\n",
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500,height: 3),

                        ),
                        TextSpan(
                          text: "If you joke wrong way, your teeth have to pay. (Serious) \n",
                          style: TextStyle(color: Colors.white, fontSize: 15, height: 3),
                        ),
                      ],
                    ),
                  ),
                )
            ),

            Padding(padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 450,
                    child: Stack(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - kToolbarHeight,
                        child: SwipeCards(
                          matchEngine: _matchEngine!,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.topCenter,
                              color: Colors.white,
                              child: Text(
                                _swipeItems[index].content.text,
                                style: const TextStyle(fontSize: 18, color: Colors.black54),
                              ),
                            );
                          },
                          onStackFinished: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Stack Finished"),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                          itemChanged: (SwipeItem item, int index) {
                            print("item: ${item.content.text}, index: $index");
                          },
                          leftSwipeAllowed: true,
                          rightSwipeAllowed: true,
                          upSwipeAllowed: true,
                          fillSpace: true,
                          likeTag: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)
                            ),
                            child: const Text('This is Funny!'),
                          ),
                          nopeTag: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)
                            ),
                            child: const Text('This is not Funny!'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: ElevatedButton(
                                onPressed: () {
                                  _matchEngine!.currentItem?.like();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  textStyle:
                                  const TextStyle(fontSize: 18),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                                child: const Text("This is Funny!"),
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _matchEngine!.currentItem?.nope();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff29B363),
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    textStyle:
                                    const TextStyle(fontSize: 18),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),

                                  ),
                                  child: const Text("This is not Funny!")),
                            ),
                          ],
                        ),
                      )
                    ])),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 50),
              child:  Container(
                  margin: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFDFDFDF)),
                    ),
                  ),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "\n There is no need to display the result of the votes. User should not see the same joke twice. User do not need to register or login to view the joke or vote for the joke. \n",
                            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 18),
                          ),
                          TextSpan(
                            text: "Copyright 2021 HLS \n",
                            style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20, height: 2),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),


          ],
        ),
      ),

    );
  }
}