import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quicko/controllers/auth_controller.dart';
import 'package:quicko/utils/show_snackbar.dart';
import 'package:quicko/views/customers/auth/login_screen.dart';

class CustomerRegisterScreen extends StatefulWidget {
  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _singUpUsers()async{
    setState(() {
      _isLoading =true;
    });
     if(_formKey.currentState!.validate()){
       await _authController.signUpUsers(email, fullName, phoneNumber, password,_image).whenComplete(() {
         setState(() {
           _formKey.currentState!.reset();
           _isLoading = false;
         });
       });
       return showSnack(context, 'Account created succesfully');
     }else{
       setState(() {
         _isLoading=false;
       });
        return showSnack(context, 'Please Fields must be not empty!');
     }
  }

  selectGalleryImage()async{
     Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
     setState(() {
       _image = im;
     });
  }
  selectCameraImage()async{
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create Customer',
                style:TextStyle(
                  fontSize: 20,
                  ),
                ),
                Stack(
                  children: [
                      _image!=null ? CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.yellow.shade900,
                      backgroundImage: MemoryImage(_image!),
                    ):CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.yellow.shade900,
                      backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                    ),
                    Positioned(
                        right: 0,
                        top: 5,
                        child: IconButton(
                          onPressed: (){
                            selectGalleryImage();
                          },
                          icon: Icon(CupertinoIcons.photo,color: Colors.white,),
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Your Email';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Full Name';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Phone Number';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Password';
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (value){
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _singUpUsers();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child:_isLoading ? CircularProgressIndicator(
                          color: Colors.white,
                        ): Text('Sing Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                          ),
                        ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have an Account'),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
