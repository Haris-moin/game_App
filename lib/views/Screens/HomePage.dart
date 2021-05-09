

import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/Home.dart';
import 'package:game_app/views/Screens/TicketConfirm.dart';
import 'package:sizer/sizer.dart';
import 'AppDrawer.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> TicketNumbers= [];
// bool buttonColor = false;
  // final List Numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50];
  List<MyButtonModal> _buttonCoorChange = [
    MyButtonModal(buttonText: "1"),
    MyButtonModal(buttonText: "2"),
    MyButtonModal(buttonText: "3"),
    MyButtonModal(buttonText: "4"),
    MyButtonModal(buttonText: "5"),
    MyButtonModal(buttonText: "6"),
    MyButtonModal(buttonText: "7"),
    MyButtonModal(buttonText: "8"),
    MyButtonModal(buttonText: "9"),
    MyButtonModal(buttonText: "10"),
    MyButtonModal(buttonText: "11"),
    MyButtonModal(buttonText: "12"),
    MyButtonModal(buttonText: "13"),
    MyButtonModal(buttonText: "14"),
    MyButtonModal(buttonText: "15"),
    MyButtonModal(buttonText: "16"),
    MyButtonModal(buttonText: "17"),
    MyButtonModal(buttonText: "18"),
    MyButtonModal(buttonText: "19"),
    MyButtonModal(buttonText: "20"),
    MyButtonModal(buttonText: "21"),
    MyButtonModal(buttonText: "22"),
    MyButtonModal(buttonText: "23"),
    MyButtonModal(buttonText: "24"),
    MyButtonModal(buttonText: "25"),
    MyButtonModal(buttonText: "26"),
    MyButtonModal(buttonText: "27"),
    MyButtonModal(buttonText: "28"),
    MyButtonModal(buttonText: "29"),
    MyButtonModal(buttonText: "30"),
    MyButtonModal(buttonText: "31"),
    MyButtonModal(buttonText: "32"),
    MyButtonModal(buttonText: "33"),
    MyButtonModal(buttonText: "34"),
    MyButtonModal(buttonText: "35"),
    MyButtonModal(buttonText: "36"),
    MyButtonModal(buttonText: "37"),
    MyButtonModal(buttonText: "38"),
    MyButtonModal(buttonText: "39"),
    MyButtonModal(buttonText: "40"),
    MyButtonModal(buttonText: "41"),
    MyButtonModal(buttonText: "42"),
    MyButtonModal(buttonText: "43"),
    MyButtonModal(buttonText: "44"),
    MyButtonModal(buttonText: "45"),
    MyButtonModal(buttonText: "46"),
    MyButtonModal(buttonText: "47"),
    MyButtonModal(buttonText: "48"),
    MyButtonModal(buttonText: "49"),
    MyButtonModal(buttonText: "50"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Bingo',),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 2.h,bottom: 2.h),
              child: Center(
                child: Text('BINGO',style: TextStyle(color: Colors.blue,fontSize: 25.sp,letterSpacing: 10,fontWeight: FontWeight.w800,)),
              ),
            ),

            Container(
                height: 72.h,
                child:  GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    crossAxisCount: 5,
                    children: _buttonCoorChange.map((MyButtonModal f) {
                      return InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 1.h,bottom: 1.h,left: 1.w, right: 1.5.w),
                            decoration: BoxDecoration(
                                color: f.changeButtonColor
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(32),

//                          border: Border.all(color: Colors.blueGrey),
                                boxShadow: [

                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 5,
                                    offset: Offset(-1, -1),
                                  ),]),

                            child: Center(
                              child: Text(f.buttonText,style: TextStyle(
                                fontSize: 25,

                              ),
                              ),
                            )),
                        onTap: () {

                          setState(() {
                            if(TicketNumbers.length<=5)
                            {
                              if(TicketNumbers.contains(f.buttonText))
                              {
                                TicketNumbers.remove(f.buttonText);
                                f.changeButtonColor = !f.changeButtonColor;

                              }
                              else if(TicketNumbers.length<5)
                              {
                                f.changeButtonColor = !f.changeButtonColor;
                                TicketNumbers.add(f.buttonText);
                              }
                            }

                            print('setstate ${f.buttonText}');


                          });
                        },
                      );
                    }).toList())
            ),

            /* Container(

              height: 50.h,
              child:   GridView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10.0),
                shrinkWrap: true,
                itemCount: Numbers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.only(top: 1.h,bottom: 1.h,left: 1.w, right: 1.w),
                    child: InkWell(

                      onTap: () {
                       setState(() {
                         buttonColor = !buttonColor;
                         print(buttonColor);
                         print(Numbers[i]);
                       });
                      },
                      child: Container(

                        decoration: BoxDecoration(
                            color: buttonColor ? Colors.red : Colors.white,
                            borderRadius: BorderRadius.circular(32),

//                          border: Border.all(color: Colors.blueGrey),
                            boxShadow: [

                              BoxShadow(
                                color: Colors.blue,
                                blurRadius: 5,
                                offset: Offset(-1, -1),
                              ),
                            ]),
                        child: Center(
                          child: Text(
                            '${Numbers[i]}',
                            style: TextStyle(
                              fontSize: 25,

                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

            ), */
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                Container(
                  width: 30.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4.w),
                  height: 5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    onPressed: () {

                      if(TicketNumbers.length==5)
                      {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return    TicketConfirm(TNo1: TicketNumbers[0], TNo2: TicketNumbers[1], TNo3: TicketNumbers[2],TNo4: TicketNumbers[3],TNo5: TicketNumbers[4],);
                        }));

                      }
                      else{
                        NumberSelectionAlert(context);
                      }

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  NumberSelectionAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Please Select five numbers.'
            ),
            actions: <Widget>[

              FlatButton(
                child: Text("ok",style: TextStyle(fontSize: 16.sp),),
                onPressed: () {

                  Navigator.of(context).pop();
                },
              ),

            ],
          ),
        );
      },
    );
  }
}

class MyButtonModal {
  final String buttonText;
  bool changeButtonColor;

  MyButtonModal({this.buttonText, this.changeButtonColor = false});
}
