import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/Payment.dart';
import 'package:ticket_card/ticket_card.dart';

import 'AppDrawer.dart';

class TicketConfirm extends StatefulWidget {
  final TNo1;
  final TNo2;
  final TNo3;
  final TNo4;
  final TNo5;

  const TicketConfirm({Key key, this.TNo1, this.TNo2, this.TNo3, this.TNo4, this.TNo5}) : super(key: key);
  @override
  _TicketConfirmState createState() => _TicketConfirmState();
}

class _TicketConfirmState extends State<TicketConfirm> {

  String Userid = FirebaseAuth.instance.currentUser.uid;
  String name= '';
  @override
  Widget build(BuildContext context) {
    String finalDate = '';



      var date = new DateTime.now().toString();

      var dateParse = DateTime.parse(date);

      var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

      setState(() {

        finalDate = formattedDate.toString() ;

      });



    //  String formattedDate = DateFormat('dd-MM-yyyy'). format(now);
    // String formattedTime = DateFormat.Hms().format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Ticket"),
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body:ListView(
        children:<Widget>[
          SizedBox(height: 20),
          Text('Confirm Ticket',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.blue)),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(20),
            child: TicketCard(
              decoration: TicketDecoration(
                  shadow: [TicketShadow(color: Colors.black, elevation: 6)],
                  border: TicketBorder(
                      color: Colors.green,
                      width: 0.1,
                      style: TicketBorderStyle.dotted
                  )
              ),
              lineFromTop: 105,
              child: Container(
                height: 200,
                width: 200,
                color: Colors.white,
                child:Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                            child:Text('Bingo',style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: FittedBox(child: Icon(Icons.assignment_turned_in_outlined,color: Colors.red,size: 30,),fit: BoxFit.fill),
                        ),
                        Text('Your Ticket'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Text(widget.TNo1),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Text(widget.TNo2),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Text(widget.TNo3),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Text(widget.TNo4),

                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Text(widget.TNo5),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30,top: 25),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: FittedBox(child: Icon(Icons.date_range_sharp,color: Colors.red,size: 25,),fit: BoxFit.fill),
                                  ),
                                  Text('Date'),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text(finalDate),
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          padding: EdgeInsets.only(left: 30,top: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: FittedBox(child: Icon(Icons.dns_rounded,color: Colors.red,size: 25,),fit: BoxFit.fill),
                                  ),
                                  Text('Draw No'),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text('12'),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30,top: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: FittedBox(child: Icon(Icons.announcement,color: Colors.red,size: 25,),fit: BoxFit.fill),
                                  ),
                                  Text('Status'),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text('Pending'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.red.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.red.withOpacity(0.12);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back',style: TextStyle(color: Colors.white))
                  ),
                ),
                SizedBox(width: 100),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.red.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.red.withOpacity(0.12);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              print(name);
                              return paymentScreen(TNo1: widget.TNo1,TNo2: widget.TNo2,TNo3: widget.TNo3,TNo4: widget.TNo4,TNo5: widget.TNo5,DrawerNo: '1', name: name,);
                            },
                          ),
                        );
                      },
                      child: Text('Next',style: TextStyle(color: Colors.white))
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').where('id' ,isEqualTo: Userid ).snapshots(),

                builder: (context, snapshot)
                {


                  if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  }
                  else{

                    return Container(
                      height: MediaQuery.of(context).size.height/3,
                      width: MediaQuery.of(context).size.width/3,
                      child: ListView.builder(
                        itemBuilder: (context, index){
                          name = snapshot.data.docs[index]['Name'];
                          return Container(

                          );
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
