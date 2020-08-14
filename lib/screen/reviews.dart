import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/review.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/init.dart';
class Reviews extends StatefulWidget{

  final String title;
  final User user;
  final int resId;
  final int resMenuId;
  final String name;
  final String imagePath;

  Reviews({
    Key key,
    @required this.title,
    @required this.user,
    @required this.resId,
    @required this.resMenuId,
    @required this.name,
    @required this.imagePath
  });

  @override
  _ReviewsState createState()=> _ReviewsState();
}

class _ReviewsState extends State<Reviews>{
  var dbHelper;
  TextEditingController reviewController;
  final _formKey = GlobalKey<FormState>();
  bool enable = false;
   Future<List<Review>>getReviewsById;
  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    reviewController = TextEditingController();
  setState(() {
     getReviewsById =  dbHelper.getReviewsById(widget.resId,widget.resMenuId);
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WillPopScope(child: 
      ListView(
        children: [
            SafeArea(child: 
            Padding(
              padding: const EdgeInsets.only(top:20,left:20, right:20),
              child: Container(
              height: 40,
              width:120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:AppCommons.appColor
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:20),
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.home, color:AppCommons.white),
                     onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: widget.user,)));
                     }
                     ),
                      SizedBox(width: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.title,
                          style:TextStyle(
                            color:AppCommons.white,
                            fontSize: 18
                          )
                        ),
                        SizedBox(width: 50,),
                        Text(widget.name,
                         style:TextStyle(
                            color:AppCommons.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          )),
                         SizedBox(width: 50,),
                          Icon(Icons.restaurant_menu, color:AppCommons.white)
                      ],
                    )
                  ],
                ),
              ),
            ),
            )
            ),//*TOP
            SizedBox(height: 10,),
            Image.asset(widget.imagePath,fit:BoxFit.fitWidth,height: 140,),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: Container(
                height:400,
                child: FutureBuilder<List<Review>>(
                  future: getReviewsById,
                  builder: (context, snapshot){
                        if(snapshot.connectionState != ConnectionState.done){

                    }
                    if(snapshot.hasError){
                      print("ERROR!!");
                      print(snapshot.error);
                    }
                    List<Review>reviewList = snapshot.data ??[];
                    return ListView.builder(
                      itemCount: reviewList.length,
                      itemBuilder: (context, index){
                          Review review = reviewList[index];
                          print(review.userId);
                          print(widget.user.id);

                          return Padding(
                            padding: const EdgeInsets.only(left:10, right:10),
                            child: Align(
                            alignment:  (widget.user.id == review.userId)?Alignment.centerRight:Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Container(
                                  height: 40,
                                  width: 220,
                                 decoration: BoxDecoration(
                                    color: (widget.user.id == review.userId)?AppCommons.appColor:AppCommons.grey,
                                    borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(review.reviews,
                                      style:TextStyle(
                                        color:AppCommons.white,
                                        fontWeight: FontWeight.bold
                                      )
                                     )
                                   ],
                                 ),
                                ) ,
                            )
                          ),
                          );
                           
                      }
                    );
                  }
                )
              ),
            ),
             Align(
               alignment: Alignment.bottomCenter,
               child: Padding(
                 padding: const EdgeInsets.only(left:10, right:10,top:10),
                 child: Container(
                   height: 60,
                   child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width - 110,
                       child: Form(
                         key: _formKey,
                         child:  TextFormField(
                      
                      controller: reviewController,
                      onChanged: (text){
                          if(text.length > 0){
                            print("hi");
                            setState(() {
                              enable = true;
                            });
                          }else{
                             print("d");
                            enable = false;
                          }
                      },
                      
                      style: TextStyle(
                        color:AppCommons.appColor,
                      ),
                      decoration: InputDecoration(
                          hintText:"Write a review for "+widget.name,
                          hintStyle: TextStyle(
                            color:AppCommons.appColor
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.appColor),
                            ),
                             disabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: AppCommons.appColor),
                            ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: Colors.red),
                            ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: AppCommons.appColor),
                            ),
                      ),
                    ),
                       )
                     ),
                     GestureDetector(
                       onTap:(){
                         if(enable){
                           var currentDate = DateTime.now().toString();
                           print(reviewController.text);
                           Review review = Review(
                             id: null,
                             userId: widget.user.id,
                             restaurantMenuId: widget.resMenuId,
                             resId: widget.resId,
                             reviews: reviewController.text,
                             upddt: currentDate
                           );
                           dbHelper.createReview(review);
                            setState(() {
                                  getReviewsById =  dbHelper.getReviewsById(widget.resId,widget.resMenuId);
                                });
                           reviewController.clear();
                           setState(() {
                             enable = false;
                           });
                         }
                       },
                       child: Container(
                         height: 50,
                         width: 80,
                         decoration: BoxDecoration(
                           border:Border.all(color: enable?AppCommons.appColor:AppCommons.grey,
                           width: 2),
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(
                           child:Icon(Icons.send, color:enable?AppCommons.appColor:AppCommons.grey)
                         ),
                       ),
                     )
                   ],
                 ),
                 )
               ),
             )
        ],
      )
      , onWillPop: ()async => false)
    );
  }

}