enum Status {
  created,
  pending,
  failed,
  sync;

  static Status fromString(String value){
    for(Status status in Status.values){
      if(status.name==value){
        return status;
      }
    }
    throw Error();
  }
}
