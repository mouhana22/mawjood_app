//import all widgets/packages
import 'package:flutter/material.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:mawjood_app/widgets/button.dart';
import 'package:mawjood_app/widgets/iconButton.dart';



class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //كنترولز للكتابة
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController jobController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Your name',
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Your phone number',
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Your email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Your password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: jobController,
            decoration: InputDecoration(
              labelText: 'Job title',
              hintText: 'Type role',
            ),
          ),
          SizedBox(height: 16.0),
          iconButton( //  icon button for scanning 
            text: 'Scan',
            icon: Icons.camera_alt,
            type: btnType.Secondary, 
            height: 50,
            width: double.infinity, 
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Checkbox(
                value: false, 
                onChanged: (bool? newValue) {
                  // ****Add the state handling logic here later****
                },
              ),
              Text('I agree to the terms')
            ],
          ),
          button(
            text: 'Register',
            type: btnType.Primary,
            height: 50,
            width: double.infinity, onPressed: () {  }, 
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Or register with check in'),
              GestureDetector(
                onTap: () {
                  // ****Add the action here later****
                },
                child: Text(
                  'check in ',
                  style: TextStyle(
                    color: Theme.of(context).canvasColor, 
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Icon(Icons.arrow_right, size: 24) //  right arrow icon
            ],
          ),

        ],
      ),
    );
  }
}

