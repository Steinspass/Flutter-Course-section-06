import 'package:flutter/material.dart';
import 'package:formvalidationbloc/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginCard(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
      
      final size = MediaQuery.of(context).size;

      final font =  Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color> [
              Color.fromRGBO(63, 63, 156, 1.0),
              Color.fromRGBO(90, 70, 178, 1.0)
            ]
          ),
        ),
      );

      final circle = Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)
        ),
      );

      final iconImage = Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon(Icons.person_pin_circle, color: Colors.white, size: 80.0 ,),
            SizedBox(height: 10.0, width: double.infinity,),
            Text('Login Bloc', style: TextStyle(color: Colors.white, fontSize: 25.0) ,)
          ],
        ),
      );
      
      
      return Stack(
        children: <Widget>[
          font,
          Positioned(top: 90.0, left: 30.0, child: circle, ),
          Positioned(top: -40.0, right: -30.0, child: circle, ),
          Positioned(bottom: -50.0, right: -10.0, child: circle, ),
          Positioned(bottom: 120.0, right: 20.0, child: circle, ),
          Positioned(bottom: -50.0, left: -20.0, child: circle, ),
          iconImage
        ],
      );
  }

  Widget _loginCard(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            padding:  EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                  )
              ]
            ),

            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 40.0 ,),
                _createEmail(bloc),
                SizedBox(height: 20.0 ,),
                _createPassword(bloc),
                SizedBox(height: 40.0 ,),
                _createButtonLogin(bloc, context),
              ],
            ),
          ),

          Text('Forgot password ?', style: TextStyle(color: Colors.black),),
          SizedBox(height: 60.0,)
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(

      padding: EdgeInsets.symmetric(horizontal: 20.0 ),

      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple ,),
          hintText: 'example@email.com',
          labelText: 'Email' ,
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: bloc.changeEmail,
      ) ,
    );
      },
    );
    
  }

  Widget _createPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple ,),
          labelText: 'Password' ,
          counterText: snapshot.data,
          errorText: snapshot.error
          
        ),
        onChanged: bloc.changePassword,
      ) ,
    );
      },
    );

     
  }

  Widget _createButtonLogin(LoginBloc bloc, BuildContext context) {

      return StreamBuilder(
        stream: bloc.formValidStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          
          return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Login'),
        ),
        onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
      );
        },
      );
  }

  _login(LoginBloc bloc, BuildContext context){
      print('=============================');
      print('Email: ${bloc.emailValue}');
      print('Password: ${bloc.passwordValue}');
      print('=============================');

      Navigator.pushReplacementNamed(context, 'home');
  }

}