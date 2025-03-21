import 'package:chat_app/constants/enums/collectivity_type.dart';

import '../../constants/enums/status.dart';

abstract class Collectivity {
  int? id;
  late final int? collectivityId;
  late final CollectivityType type;
  late final Status status;
  Collectivity({required this.collectivityId,required this.type,required this.status,this.id});

  void setId(int id){
    this.id=id;
  }
}
