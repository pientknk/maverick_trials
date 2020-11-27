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

String shortFriendlyFormatNumber(int value){
  if(value == null){
    return '0';
  }

  String numberAsString = value.toString();
  int numberLength = numberAsString.length;
  double adjustedValue;
  String label;

  //1 million or greater
  //show 3 characters then the label
  if(numberLength >= 6){
    adjustedValue = value.toDouble() / 1000000;
    label = "M";
  }
  else if(numberLength >= 3){
    adjustedValue = value.toDouble() / 1000;
    label = "K";
  }
  else{
    adjustedValue = value.toDouble();
    label = "";
  }

  int truncatedValue = adjustedValue.truncate();
  if(truncatedValue == adjustedValue){
    return "$truncatedValue$label";
  }
  else{
    return "$adjustedValue$label";
  }
}