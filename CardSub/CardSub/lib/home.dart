import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:sebiomo/models/debits.dart';
import 'package:sebiomo/models/debitCard.dart';
import 'package:flutter/services.dart';
import 'package:sebiomo/utils/colors/color_consts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final numCards = 10;
  List<debitCard> getCards(){ 
      List<debitCard> cards = [];//num cards is length of cards list.
      int mm = 08;
      int yy = 21;
      int ldigits = 928;
      for (int a = 0; a < numCards; a++){
        cards.add(debitCard(expDate:'$mm/$yy',lastDigits:'$ldigits')); 
        ldigits += 1;
        mm += 1;
        yy += 1;
      }
      return cards;
  }
  Widget makeCardContainer(String lastCardDigits, String expirationDate) {
    return Container(
                margin: EdgeInsets.fromLTRB(0,0,10,0),
                width: 310,
                height: 150,
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '**** **** **** 0$lastCardDigits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: workSans,
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text(
                      'EXP: $expirationDate',
                      style: TextStyle(
                        color: lightBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: workSans,
                      ),
                    ),
                  ],
                ),
              );
  }

  List<Debits> upcomingDebits = [
    Debits(companyName: 'Netflix', date: '1-May-2021', amount: '3,400', lastCardDigits: '8898', avatarForeground: pink, avatarBackground: lightPink),
    Debits(companyName: 'Udacity', date: '5-May-2021', amount: '18,200', lastCardDigits: '8898', avatarForeground: deepOrange, avatarBackground: lightOrange),
    Debits(companyName: 'MusicBed', date: '12-May-2021', amount: '4,500', lastCardDigits: '8898', avatarForeground: deepPurple, avatarBackground: lightPurple),
    Debits(companyName: 'Swift Internet', date: '15-May-2021', amount: '3,400', lastCardDigits: '5766', avatarForeground: deepCyan, avatarBackground: lightCyan),
    Debits(companyName: 'PiggyVest', date: '19-May-2021', amount: '52,000', lastCardDigits: '5766', avatarForeground: deepBlue, avatarBackground: lightBlue),
    Debits(companyName: 'Epic Games', date: '13-May-2021', amount: '2,000', lastCardDigits: '5766', avatarForeground: deepBlue, avatarBackground: lightBlue),
    Debits(companyName:'Apple', date:'14-Apr-2021', amount: '34,000', lastCardDigits:'9832', avatarForeground: deepBlue, avatarBackground: lightBlue),
  ];

  int selectedItem = -1;
  double height = 90;

  AnimatedContainer debitListItem({String companyName, String date, String amount, String lastCardDigits, Color avatarForeground, Color avatarBackground, Color cardBg, Color textColor, Widget actionSection, double height}) {
    return AnimatedContainer(
      height: height,
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: avatarBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              companyName.substring(0,1),
                              style: TextStyle(
                                color: avatarForeground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              companyName,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              date,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('NGN ${amount}',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('**** ${lastCardDigits}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (actionSection != null) ? actionSection : SizedBox(height: 0,),
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
//            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your Cards',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: workSansBold,
                            fontWeight: FontWeight.w800,
                            color: textGrey
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: ()=> Navigator.of(context).pushNamed('/add_card'),
                        color: Colors.cyan[900],
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Icon(Icons.add, color: Colors.white,),
                        ),
                        label: Text('Add Card', style: TextStyle(color: Colors.white, fontFamily: workSans,),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal ,
                    child: Row(
                      children: <Widget>[
                          SizedBox(width: 20,),
                          for (var card in getCards()) makeCardContainer(card.lastDigits,card.expDate),
                          SizedBox(width: 10,)
                        ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Upcoming Debits',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: workSans,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        color: lightGrey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Icon(Icons.keyboard_arrow_down, color: textGrey,),
                        ),
                        label: Text('Current Month', style: TextStyle(color: textGrey, fontFamily: workSans, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: upcomingDebits.length,
                    itemBuilder: (BuildContext context, index){
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // print('tapped: ${upcomingDebits[index].companyName}');

                              if(selectedItem == -1) {
                                setState(() {
                                  selectedItem = index;
                                });
                              } else if (selectedItem == index) {
                                setState(() {
                                  selectedItem = -1;
                                });
                              } else {
                                setState(() {
                                  selectedItem = index;
                                });
                              }

                              // print(selectedItem);
                            },
                            child: debitListItem(
                              height: (selectedItem == index) ? 140 : height,
                              companyName: upcomingDebits[index].companyName,
                              date: upcomingDebits[index].date,
                              amount: upcomingDebits[index].amount,
                              lastCardDigits: upcomingDebits[index].lastCardDigits,
                              avatarForeground: upcomingDebits[index].avatarForeground,
                              avatarBackground: upcomingDebits[index].avatarBackground,
                              cardBg: (selectedItem == index) ? darkGrey : cardsBg,
                              textColor: (selectedItem == index) ? Colors.white : textGrey,
                              actionSection: (selectedItem == index) ?

                              DelayedDisplay(
                                delay: Duration(milliseconds: 1),
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 0),
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.access_time, color: Colors.grey[400], size: 14,),
                                            SizedBox(width: 2,),
                                            Text(
                                              'Set disconnection date',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 12,
                                                fontFamily: workSans,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Icon(Icons.close, color: Colors.black87, size: 14,),
                                            SizedBox(width: 2,),
                                            Text(
                                              'Disconnect Now',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                fontFamily: workSans,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      );
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
