import 'dart:io';

void main(List<String> args) {
  //nhập dãy số
  print('Bạn hãy nhập 5 số phân cách nhau bằng khoảng trắng');
  String arr = stdin.readLineSync() ?? '';

  RegExp nonDigitRegExp = RegExp(r'\D');
  if (nonDigitRegExp.hasMatch(arr.replaceAll(" ", ""))) {
    print('Bạn đã nhập sai');
  } else {
    //tách dãy số
    List<int> listInt = arr.split("").map(int.parse).toList();
    print(listInt);
    
    int min = listInt[0];
    int max = listInt[0];
    int sum = 0;
    int sumMin = 0;
    int sumMax = 0;

    if (listInt.length == 5) {
      for (var i = 0; i < listInt.length; i++) {
        //tìm số bé nhất, số lớn nhất
        if(min > listInt[i]){
          min = listInt[i];
        };
        if(min < listInt[i]){
          max = listInt[i];
        };
        //tính tổng
        sum = sum + listInt[i];
      }
      //tính tổng sumMin, sumMax
      sumMax = sum - min;
      sumMin = sum - max;
      print('$sumMin, $sumMax');
    } else {
      print('Bạn đã nhập sai');
    }
  }

  
  
  
 
}