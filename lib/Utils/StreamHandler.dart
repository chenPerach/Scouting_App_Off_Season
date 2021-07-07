import 'dart:async';


class StreamHandler{
  Set<StreamSubscription> _streamSubscriptions;
  
  void addStream(StreamSubscription sub){
    _streamSubscriptions.add(sub);
  }
  void cancelStream(StreamSubscription sub){
    _streamSubscriptions.remove(sub);
    sub.cancel();
  }
  void cancelAll(){
    for(var s in _streamSubscriptions){
      s.cancel();
    }
    _streamSubscriptions = Set();
  }
  StreamHandler(){
    _streamSubscriptions = Set();
  }


  
}