import 'package:flutter/material.dart';
import 'package:quicko/controllers/auth_controller.dart';
import 'package:quicko/utils/show_snackbar.dart';
import 'package:quicko/views/customers/auth/register_screen.dart';
import 'package:quicko/views/customers/main_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  final AuthController _authController =AuthController();

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers()async{
      if(_formKey.currentState!.validate()){
          String res = await _authController.loginUsers(email, password);
          if(res =='success'){
            return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){return MainScreen();
            }));
          }else{
            return showSnack(context, res);
          }

          //return showSnack(context, 'You are now Logged In');
      }else{
        return showSnack(context,'Please Fields must be not empty');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login Customers',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  validator: ((value){
                    if(value!.isEmpty){
                      return 'Please Email field must be not empty';
                    }
                    else{
                      return null;
                    }
                  }),
                  onChanged: ((value){
                      email = value;
                    }
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  obscureText: true,
                  validator: ((value){
                    if(value!.isEmpty){
                      return 'Please Password field must be not empty';
                    }
                    else{
                      return null;
                    }
                  }),
                  onChanged: ((value){
                    password = value;
                  }
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  _loginUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width -40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:_isLoading ? CircularProgressIndicator(color: Colors.white,) : Text('Sing Up',
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
                  Text('Need an account'),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return CustomerRegisterScreen();
                          }));
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
