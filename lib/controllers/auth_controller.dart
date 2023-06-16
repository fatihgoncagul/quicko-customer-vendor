import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  pickProfileImage(ImageSource source)async{
      final ImagePicker _imagePicker = ImagePicker();
      XFile? _file = await _imagePicker.pickImage(source: source);

      if(_file!=null){
          return await _file.readAsBytes();
      }
      else{
        print('No Image Picked');
      }
  }

  Future<String> signUpUsers(String email,String fullName,String phoneNumber,String password)async{

    String res = 'Some error occured';

    try{
      if(email.isNotEmpty && fullName.isNotEmpty && phoneNumber.isNotEmpty && password.isNotEmpty){
        //Create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email':email,
          'fullName':fullName,
          'phoneNumber':phoneNumber,
          'buyerId':cred.user!.uid,
          'address':'',
        });
        res ='success';
      }
      else{
        res ='Please Fields must not be empty';
      }
    }catch(e){

    }
    return res;
  }
  loginUsers(String email,String password)async{
    String res = 'something went wrong';

    try{
      if(email.isNotEmpty && password.isNotEmpty){
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          res ='success';
      }
      else{
        res='Please Fields must be not empty';
      }
    }catch(e){
        res=e.toString();
    }
    return res;
  }
}