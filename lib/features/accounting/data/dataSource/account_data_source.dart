import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_order_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';

import 'package:food_order_app/features/accounting/domain/entity/account.dart';

class AccountDataSource {
  final Supabase supabase;

  // final SupabaseAuth supabaseAuth;

  AccountDataSource({required this.supabase
      // required this.supabaseAuth,
      });

  Future<Account> signUpUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await supabase.client.auth.signUp(email, password);
      if (response.error != null) {
        throw ServerException(response.error!.message);
      } else {
        return await getAccountFromDataBase(response.user!.id);
      }
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  
  Future<Account> signInUserWithEmailAndPassword(String email,String password) async{
    try{
      final response =await supabase.client.auth.signIn(email: email,password: password);
      if(response.error !=null){
        throw ServerException(response.error!.message);
      }else{
        return await getAccountFromDataBase(response.user!.id);
      }
    }catch (error){
      throw ServerException(error.toString());
    }
  }


  Future<void> updateAccountData(Account newAccount) async {
    try{
      final currentUserId = supabase.client.auth.currentUser!.id;
      final authResponse = await supabase.client.auth.update(UserAttributes(email: newAccount.email,));
      if(authResponse.error != null){
        throw ServerException(authResponse.error!.message);
      }
      final response = await supabase.client.from('users').update(newAccount.toMap()).eq('id', currentUserId).execute();
      if(response.error != null){
        throw ServerException(response.error!.message);
      }
    }catch(error){
      throw ServerException(error.toString());
    }
  }

  Future<Account> getAccountFromDataBase(String id) async{
    final tableResponse = await supabase.client
            .from('users')
            .select('*')
            .eq('id', id)
            .execute();
        if (tableResponse.error != null) {
          throw ServerException(tableResponse.error!.message);
        } else {
          debugPrint(tableResponse.data.toString());
          final users = tableResponse.data as List<dynamic>;
          if (users.isEmpty) {
            throw const ServerException('no such user have been found!');
          } else {
            final user = Account.fromMap(users[0]);
            return user;
          }
        }
  }

}
