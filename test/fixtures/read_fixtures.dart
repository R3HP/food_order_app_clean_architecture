import 'dart:io';

String readFixture(String path){
  return File(path).readAsStringSync();
}