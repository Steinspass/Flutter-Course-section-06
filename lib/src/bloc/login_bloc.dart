

import 'dart:async';

import 'package:formvalidationbloc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

// Insertar valores al Stream

  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

 
// Recuperar los datos del Stream

  Stream<String> get emailStream    => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );

  Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);


// Obtener el ultimo valor agregado a los stream

  String get emailValue => _emailController.value;
  String get passwordValue => _passwordController.value;


  dispose(){
    _emailController?.close();
    _passwordController?.close();
  } 



}