enum Status {
  CREATED,
  PENDING,
  FAILED,
  SYNC;

  static Status fromString(String value){
    for(Status status in Status.values){
      if(status.name==value){
        return status;
      }
    }
    throw Error();
  }
}
