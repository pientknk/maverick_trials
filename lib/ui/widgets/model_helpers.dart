class ModelHelpers {
  static List<T> createListFromJson<T>(dynamic jsonList, T tFromJson){
    List<T> list = List<T>();
    /*if(jsonList != null){
      List jsonAsList = jsonList as List;
      jsonAsList.forEach((value) {
        list.add(tFromJson())
      });
    }

     */

    return list;
  }
}