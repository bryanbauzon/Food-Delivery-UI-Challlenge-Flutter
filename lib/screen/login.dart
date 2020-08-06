import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';
import 'package:food_delivery_ui_challenge/util/app-util.dart';

class Login extends StatefulWidget{
    @override
    _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>{

  var dbHelper;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username;
  bool isSignup = false;
  bool isUsernameExistInd = false;
  bool invalidUsername = false;
  bool isSuccessLogin = false;
  bool isClickedSignIn = false;
  var _scaffoldKey;
  int basketCount = 0;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    username = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  
  }
  Widget usernameWidget()=>TextFormField(
                      controller: username,
                      validator: (text){
                        if(isUsernameExistInd){
                           return AppCommons.username+" already taken.";
                        }
                        if(text.isEmpty){
                          return AppCommons.username+" is empty.";
                        }
                        return null;
                      },
                      style: TextStyle(
                        color:AppCommons.appColor,
                        fontWeight:FontWeight.bold
                      ),
                      decoration: InputDecoration(
                          labelText: AppCommons.username,
                          labelStyle: TextStyle(
                            color:AppCommons.appColor
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.appColor),
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
                    );
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppCommons.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:40, right:40),
              child: Column(
                children: <Widget>[
                      Form(
                      key: _formKey,
                        child: usernameWidget()
                      ),
                  SizedBox(height: 20,),

                 !isSignup? GestureDetector(
                    onTap:(){
                      if(_formKey.currentState.validate()){
                        if(!isClickedSignIn){
                          setState(() {
                          isClickedSignIn = true;
                            isSuccessLogin = true;
                        });
                  
                           if(isUsernameExistInd){
                            setState(() {
                              isUsernameExistInd = false;
                            });
                           }
                         
                           Future<User> loginCredentials = dbHelper.checkLoginCredentialsByUsername(username.text);
                           loginCredentials.then((value){
                                setState(() {
                                Future<int> orderCount = dbHelper.orderCount(value.id);
                                orderCount.then((value){
                                  basketCount = value;
                                });
                              });
                              print(value.id);
                             FocusScope.of(context).unfocus();
                              
                             Future.delayed(Duration(milliseconds: 500),(){
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (_)=>HomePage(title: AppCommons.appName,user: value,basketCount: basketCount,))
                                );
                                setState(() {
                                  isClickedSignIn = false;
                                  isSuccessLogin = false;
                                });
                             });
                           }).catchError((onError){
                             print(onError);
                             setState(() {
                               isClickedSignIn = false;
                                isSuccessLogin = false;
                             });
                              AppUtil().showSnackBarByScaffoldKey("Invalid username.", _scaffoldKey);
                           });
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                        color: AppCommons.appColor
                      ),
                      child: Center(
                        child: Text(
                         isSuccessLogin?AppCommons.pleaseWait:AppCommons.signin,
                          style: TextStyle(
                            color:AppCommons.white,
                            fontWeight:FontWeight.bold,
                            fontSize:18
                          ),
                        ),
                      ),
                    ),
                  ): GestureDetector(
                    onTap:(){
                      if(_formKey.currentState.validate()){
                          
                          Future<bool> isUsernameExist = dbHelper.isUsernameExist(username.text);
                           isUsernameExist.then((value){
                              if(value){
                                setState(() {
                                  isUsernameExistInd = value;
                                });
                              }else{
                                  User createUser = User(id: null, username: username.text);
                                    Future<User> user = dbHelper.createUserAccount(createUser);
                                    user.then((value){
                                        print("Success:"+value.username);
                                        setState(() {
                                          isSignup = false;
                                          username.clear();
                                        });
                                    }).catchError((onError){
                                        print(onError);
                                    });
                              }
                           });
                           
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                        color: AppCommons.appColor
                      ),
                      child: Center(
                        child: Text(
                          AppCommons.signup,
                          style: TextStyle(
                            color:AppCommons.white,
                            fontWeight:FontWeight.bold,
                            fontSize:18
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                 !isSignup? Row(
                    children: <Widget>[
                      Text(AppCommons.notYetReg),
                      GestureDetector(
                        onTap: (){
                             setState(() {
                               isSignup = !(isSignup);
                             });
                        },
                        child: Text(AppCommons.signup,
                          style: TextStyle(
                            color:AppCommons.appColor,
                            fontWeight:FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ):GestureDetector(
                    onTap: (){
                          setState(() {
                               isSignup = !(isSignup);
                             });
                    },
                    child: Text(AppCommons.back,
                     style: TextStyle(
                            color:AppCommons.appColor,
                            fontWeight:FontWeight.bold
                          ),
                    ),
                  )
                ],
              )
            )
        ],
      ),
    );
  }
}