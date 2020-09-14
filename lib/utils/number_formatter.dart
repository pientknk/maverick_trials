String friendlyFormatNumber(int value){
  if(value == null){
    return  '0';
  }

  String numberAsString = value.toString();

  int numberLength = numberAsString.length;
  int spaceOffset = numberLength % 3;
  String formattedStringNumber = '';
  if(numberLength > 3){
    for(int i = 0; i < numberAsString.length; i++){
      if(spaceOffset == 0){
        spaceOffset += 3;
      }

      if(i == spaceOffset){
        formattedStringNumber += ' ';
        spaceOffset += 3;
      }

      formattedStringNumber += numberAsString[i];
    }
  }
  else{
    formattedStringNumber = numberAsString;
  }

  return formattedStringNumber;
}