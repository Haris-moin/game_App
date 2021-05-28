
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_card/ticket_card.dart';

import 'AppDrawer.dart';
import 'Home.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String UserID = FirebaseAuth.instance.currentUser.uid;
String name = '';
String email = '';
String phone = '';

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
                    .collection('Tickets').orderBy('TicketID', descending: true)
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



                        if(snapshot.data.docs[index]['UserId']== UserID)
                          {

                            return Container(
                              padding: EdgeInsets.all(25),
                              child: TicketCard(

                                decoration: TicketDecoration(
                                    shadow: [
                                      TicketShadow(
                                          color: Colors.black, elevation: 10)
                                    ],
                                    ),
                                lineFromTop: 116,
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

                                      Row(
                                        children: [
                                          Expanded(

                                            child: Row(

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
                                                  margin: EdgeInsets.only(left: 8),
                                                ),
                                                Text('Your Ticket'),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only( right: 10),
                                            child:  ElevatedButton(

                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.brown,
                                              ),
                                              child: Text('Claim',style: TextStyle(fontSize: 14),),
                                              onPressed: () {
                                                if(snapshot.data.docs[index]['status']=='pending')
                                                  {
                                                    DenyAlert(context);
                                                  }
                                              else{
                                                /* _ClaimForReward(
                                                      snapshot.data.docs[index]['TicketNo'][0],
                                                      snapshot.data.docs[index]['TicketNo'][1],
                                                      snapshot.data.docs[index]['TicketNo'][2],
                                                      snapshot.data.docs[index]['TicketNo'][3],
                                                      snapshot.data.docs[index]['TicketNo'][4],
                                                      snapshot.data.docs[index]['Transaction Id'],
                                                      snapshot.data.docs[index]['Draw No'],
                                                      snapshot.data.docs[index]['TicketID'],
                                                      UserID,
                                                      snapshot.data.docs[index]['Date'],
                                                      name, email, phone
                                                  ); */
                                                 _checkClaim( snapshot.data.docs[index]['TicketNo'][0],
                                                     snapshot.data.docs[index]['TicketNo'][1],
                                                     snapshot.data.docs[index]['TicketNo'][2],
                                                     snapshot.data.docs[index]['TicketNo'][3],
                                                     snapshot.data.docs[index]['TicketNo'][4],
                                                     snapshot.data.docs[index]['Transaction Id'],
                                                     snapshot.data.docs[index]['Draw No'],
                                                     snapshot.data.docs[index]['TicketID'],
                                                     UserID,
                                                     snapshot.data.docs[index]['Date'],
                                                     name, email, phone);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
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
            Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').where('id' ,isEqualTo: UserID ).snapshots(),

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
                            email = snapshot.data.docs[index]['email'];
                            phone = snapshot.data.docs[index]['phone'];

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
      ),
    );
  }

  DenyAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Your Ticket is still in pending you Can\'t claim'
            ),
            actions: <Widget>[

              FlatButton(
                child: Text("ok",style: TextStyle(fontSize: 16),),
                onPressed: () async{

                  await Navigator.pop(context);
                },
              ),

            ],
          ),
        );
      },
    );
  }



  _checkClaim(T1 ,T2 ,T3,T4,T5,TransId,DrawNo,TicketId,UserId,Date,name,email,phone) {
    FirebaseFirestore.instance
        .collection("ClaimTickets")
        .where("TicketId", isEqualTo: TicketId)
        .get()
        .then((querySnapshot) {
      var query = querySnapshot.docs.first.data();
      print(query);
      AgainClaimAlert(context);
      // doc.data() is never undefined for query doc snapshots
    }).onError((error, stackTrace) {
      print(error);
      _ClaimForReward(T1, T2, T3, T4, T5, TransId, DrawNo, TicketId, UserId, Date, name, email, phone);
    });
  }


  ClaimAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Your Claim has submitted successfully.'
            ),
            actions: <Widget>[

              FlatButton(
                child: Text("ok",style: TextStyle(fontSize: 16),),
                onPressed: () async{

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Home();
                      },
                    ),
                  );
                },
              ),

            ],
          ),
        );
      },
    );
  }

  AgainClaimAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('You Have Claimed this ticket'),
            actions: <Widget>[
              FlatButton(
                child: Text("ok"),
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

  _ClaimForReward(T1 ,T2 ,T3,T4,T5,TransId,DrawNo,TicketId,UserId,Date,name,email,phone)
  async{
    List<String> TicketNumber =[T1,T2,T3,T4,T5];
    await FirebaseFirestore.instance.collection('ClaimTickets').doc().set(
        {
          'userId': UserId , 'UserName' : name ,'UserEmail' : email, 'PhoneNumber' : phone , 'TicketDate' : Date, 'claimStatus': 'unchecked',
          'TransactionId' : TransId , 'DrawNo' : DrawNo , 'TicketId' : TicketId , 'TicketNo' : FieldValue.arrayUnion(TicketNumber),
        }

    );
    ClaimAlert(context);
  }
}
