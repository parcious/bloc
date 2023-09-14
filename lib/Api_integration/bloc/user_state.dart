import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

 
 @immutable
 abstract class UserState extends Equatable{}


class UserLoadingState extends UserState{
  List<Object?> get props => [];
 }

class UserLoadedState extends UserState{
  final users;
  UserLoadedState(this.users);
  
  List<Object?> get props => [users];
 }


class UserErrorState extends UserState{
  final String error;
  UserErrorState(this.error);
  
  List<Object?> get props => [error];
 }