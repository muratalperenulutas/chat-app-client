enum CollectivityType {
  DYAD,
  GROUP;

  static CollectivityType fromString(String value){
    for(CollectivityType type in CollectivityType.values){
      if(type.name==value){
        return type;
      }
    }
    throw Error();
  }
}
