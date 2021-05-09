import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_card/ticket_card.dart';

import 'AppDrawer.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String UserID = FirebaseAuth.instance.currentUser.uid;

  String finalDate = '';

  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.2,
              child: StreamBuilder(

                stream: FirebaseFirestore.instance
                    .collection('Tickets')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  } else {

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width / 4,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {

                          print('run 2');

                        if(snapshot.data.docs[index]['UserId']== UserID)
                          {
                            print('run 3');
                            return Container(
                              padding: EdgeInsets.all(20),
                              child: TicketCard(
                                decoration: TicketDecoration(
                                    shadow: [
                                      TicketShadow(
                                          color: Colors.black, elevation: 6)
                                    ],
                                    border: TicketBorder(
                                        color: Colors.green,
                                        width: 0.1,
                                        style: TicketBorderStyle.dotted)),
                                lineFromTop: 105,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                              ),
                                              child: Text('Bingo',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: FittedBox(
                                                child: Icon(
                                                  Icons
                                                      .assignment_turned_in_outlined,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                          Text('Your Ticket'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                         child: Text(snapshot.data.docs[index]['TicketNo'][0],),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                          child: Text(snapshot.data.docs[index]['TicketNo'][1],),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                          child: Text(snapshot.data.docs[index]['TicketNo'][2],),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                         child: Text(snapshot.data.docs[index]['TicketNo'][3],),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                          child: Text(snapshot.data.docs[index]['TicketNo'][4],),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 30, top: 25),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: FittedBox(
                                                          child: Icon(
                                                            Icons
                                                                .date_range_sharp,
                                                            color: Colors.red,
                                                            size: 25,
                                                          ),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    Text('Date'),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(snapshot.data.docs[index]['Date']),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 30, top: 25),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: FittedBox(
                                                          child: Icon(
                                                            Icons.dns_rounded,
                                                            color: Colors.red,
                                                            size: 25,
                                                          ),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    Text('Draw No'),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                               Text(snapshot.data.docs[index]['Draw No']),
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
                                                Text(snapshot.data.docs[index]['status']),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        else{
                          print('run 4');
                          return Container();
                        }
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    );
                  }
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
