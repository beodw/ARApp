import 'package:flutter/material.dart';
import 'package:sebiomo/utils/colors/color_consts.dart';
import 'package:google_fonts/google_fonts.dart';

class addCard extends StatefulWidget{
  @override
  _addCardState createState() => _addCardState();

}
class _addCardState extends State<addCard> {
  final _cardNumberFieldTextController = TextEditingController();
  void _nextScreen(){
    if (_cardNumberFieldTextController.value.text.isNotEmpty){ 
      Navigator.of(context).pushNamed('/');
    }
    else{
      //makeBorderRed
    }
  } 
  TextField cardNumberField = TextField(
                                        onChanged:(String text){},
                                        decoration: InputDecoration(
                                                contentPadding:EdgeInsets.only(left:20.0),
                                                border: OutlineInputBorder(
                                                  borderRadius: const BorderRadius.all(
                                                    const Radius.circular(30.0),
                                                  ),
                                                ),
                                                filled: true,
                                                hintStyle: new TextStyle(color: Colors.grey[800]),
                                                hintText: "Enter Card Number...",
                                                fillColor: Colors.white70
                                            ),
                                      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg, //bg defined in color_consts
      body: Center(
        child: Container(
                        height: 150,
                        width: 310,
                        child:Column(
                                  children:<Widget>[
                                      cardNumberField,
                                      Padding(
                                        padding:const EdgeInsets.only(top:8.0), 
                                        child:Row( 
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children : [MaterialButton(
                                                          onPressed: _nextScreen,
                                                          elevation: 0.0,
                                                          color: bg,
                                                          textColor: darkGrey,
                                                          child: Icon(
                                                            Icons.arrow_forward_outlined,
                                                            size: 30,
                                                          ),
                                                          padding: EdgeInsets.all(16),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: const BorderRadius.all(
                                                                            const Radius.circular(30.0),
                                                                        ),
                                                              ),
                                                        ),
                                                ],
                                        ),

                                      ), 
                                  ]
                                ),
                        ),
      ),
    );
  }
}