import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../services/databse.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController todoController=new TextEditingController();

  bool today=true,tomorrow=false,nextWeek=false;
  bool suggest=false;

  Stream? todoStream;

  getontheload()async{
    todoStream=await DatabaseMethods().getAllTheWork(today? "Today":tomorrow?"Tomorrow":"NextWeek");
    setState(() {

    });
  }


  @override
  void initState() {
    getontheload();
    super.initState();
  }


  Widget allWork(){
    return StreamBuilder(stream:todoStream,
        builder: (context,AsyncSnapshot snapshot){
      return
        snapshot.hasData? Expanded(
          child: ListView.builder(

            padding:EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
                DocumentSnapshot ds=snapshot.data.docs[index];
                return
          CheckboxListTile(
          activeColor: Color(0xFF1761fb),
          title: Text( ds["Work"],style: TextStyle(color: Colors.white,fontSize: 25,
          
              fontWeight: FontWeight.w400
          ),

          ),
          
          
          value: ds["Yes"], onChanged: (newValue) async{

            await DatabaseMethods().updateIfTicked(ds["Id"], today? "Today":tomorrow?"Tomorrow":"NextWeek");
          setState(() {

            Future.delayed(Duration(seconds: 2),(){
              DatabaseMethods().removeMethod(ds["Id"],
                  today? "Today":tomorrow?"Tomorrow":"NextWeek");
            });

          },
          
          );
                },
          controlAffinity: ListTileControlAffinity.leading,
                );
          
                }),
        ):CircularProgressIndicator();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: (){
            openBox();
      },
      child: Icon(Icons.add,color: Color(0xFF1761fb),size: 30.0,),

      ),
      body: Container(
        padding: EdgeInsets.only(top: 90,left: 30.0),

       height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.deepPurpleAccent,Colors.lightBlue,Colors.deepPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("HELLO\nANSHUMAN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      fontWeight: FontWeight.bold),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Get Pumped Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),

                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                       today? Material(

                          elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:5.0 ),
                            decoration: BoxDecoration(
                              color: Color(0xFF1761fb),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("Today",style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ):GestureDetector(

                         onTap: () async{
                           today=true;
                           tomorrow=false;
                           nextWeek=false;
                           await getontheload();

                           setState(() {

                           });
                         },
                          child: Text("Today",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),),
                        ),
                        tomorrow? Material(

                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:5.0 ),
                            decoration: BoxDecoration(
                                color: Color(0xFF1761fb),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("Tomorrow",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ):GestureDetector(

                          onTap: () async{
                            today=false;
                            tomorrow=true;
                            nextWeek=false;
                            await getontheload();

                            setState(() {

                            });
                          },
                          child: Text("Tomorrow",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        nextWeek? Material(

                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:5.0 ),
                            decoration: BoxDecoration(
                                color: Color(0xFF1761fb),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text("Next Week",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ):GestureDetector(

                          onTap: () async{
                            today=false;
                            tomorrow=false;
                            nextWeek=true;
                              await getontheload();
                            setState(() {

                            });
                          },
                          child: Text("Next Week",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    allWork(),




                  ],
                ),
      ),
    );
  }
  Future openBox()=> showDialog(context: context, builder: (context)=>AlertDialog(

    content: SingleChildScrollView(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel),
              ),
              SizedBox(
                width: 60,
              ),
              Text('Add the work To-Do',style: TextStyle(
                  color: Color(0xFF1761fb),
                  fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('Add Text'),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),

            decoration: BoxDecoration(

              border:Border.all(
                color: Colors.black,
                width: 2.0
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: TextField(
                    controller: todoController,

              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter text"
              ),
            ),


          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFF1761fb),
                borderRadius: BorderRadius.circular(10)
              ),

              child: GestureDetector(

                onTap: (){
                  String id=randomAlphaNumeric(10);

                  Map<String, dynamic> userToDo={
                    "Work":todoController.text,
                    "Id":id,
                    "Yes":false
                  }; //dynamic means it can allow long int etc etc

                  today? DatabaseMethods().addTodayWork(userToDo, id):tomorrow? DatabaseMethods().addTomorrowWork(userToDo, id) :DatabaseMethods().addNextWeek(userToDo, id);
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text("Add",style: TextStyle(
                    color: Colors.white,
                
                  ),),
                ),
              ),
            ),
          )


        ],

      ),
    ),
  ));


}
