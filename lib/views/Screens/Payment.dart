import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/Home.dart';

import 'AppDrawer.dart';
import 'EditProfile.dart';

class paymentScreen extends StatefulWidget {
  final TNo1;
  final TNo2;
  final TNo3;
  final TNo4;
  final TNo5;
  final DrawerNo;
  final name;
  const paymentScreen({Key key, this.TNo1, this.TNo2, this.TNo3, this.TNo4, this.TNo5, this.DrawerNo, this.name}) : super(key: key);
  @override
  _paymentScreenState createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen > {
  TextEditingController TransactionIdController = TextEditingController();
  final String UserId = FirebaseAuth.instance.currentUser.uid;

  String finalDate = '';
  int TicketId ;

  getTicketID(){

    setState(() {

      TicketId = DateTime.now().millisecondsSinceEpoch ;

    });

  }
  getCurrentDate(){

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {

      finalDate = formattedDate.toString() ;

    });

  }

  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body:ListView(
        children:<Widget>[
          SizedBox(height: 20),
          Text('Make Payment',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue)),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(20),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width:10),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: FittedBox(child: Icon(Icons.payment_outlined,color: Colors.red,size: 30,),fit: BoxFit.fill),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Pay Rs 200.00',style: TextStyle(color:Colors.green),),
                            SizedBox(width:10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text('Enter Your EasyPaisa Transaction ID ',textAlign: TextAlign.center),
                 Form(
                   key: _formkey,
                   child: Column(
                     children: [
                       Container(
                         padding: EdgeInsets.all(10),
                         child: new TextFormField(
                           controller: TransactionIdController,
                           decoration: new InputDecoration(
                             labelText: "Transaction ID",
                             fillColor: Colors.white,
                             border: new OutlineInputBorder(
                               borderRadius: new BorderRadius.circular(25.0),
                               borderSide: new BorderSide(
                               ),
                             ),
                             //fillColor: Colors.green
                           ),
                           validator: (val) {
                             if(val.length==0) {
                               return "Field cannot be empty";
                             }else{
                               return null;
                             }
                           },
                           keyboardType: TextInputType.number,
                           style: new TextStyle(
                             fontFamily: "Poppins",
                           ),
                         ),
                       ),
                       SizedBox(height: 8,),
                       Container(
                         margin: EdgeInsets.all(7),
                         width: MediaQuery.of(context).size.width/5,
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
                               if(_formkey.currentState.validate() )
                               {

                                 getCurrentDate();
                                 getTicketID();
                                 _UploadTiket(widget.TNo1, widget.TNo2, widget.TNo3, widget.TNo4,widget.TNo5,TransactionIdController.text,UserId,widget.DrawerNo,finalDate,widget.name,TicketId);


                               }
                             },
                             child: Text('Submit',style: TextStyle(color: Colors.white))
                         ),
                       ),
                     ],
                   ),
                 )
               /*   SizedBox(
                    height: 90,
                    width: 90,
                    child: Image(image: AssetImage('assets/images/easypaisa.png'),),
                  ), */
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }
  PaymetAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Your Ticket has submitted successfully.'
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
  _UploadTiket(T1 ,T2 ,T3,T4,T5,TransId,UserId,DrawNo,Date,name,TicketId)
 async {

    List<String> TicketNumbers= [T1,T2,T3,T4,T5];
   await FirebaseFirestore.instance.collection('Tickets').doc().set(
        { 'UserId': UserId, 'Draw No' : DrawNo, "TicketNo": FieldValue.arrayUnion(TicketNumbers), 'Transaction Id': TransId, 'Date' : Date  , 'Name' : name , 'status' : 'pending','TicketID' : TicketId});
    PaymetAlert(context);
  }

}
