enum NetworkResponseErrorType{
  socket,
  exception,
  responseEmpty,
  didNotSucceed
}

enum CallBackParameterName {
  all,
  organic_results
}

extension CallBackParameterNameExtention on CallBackParameterName {
  dynamic getJson(json){
    if(json == null) return null;
    switch(this){
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.organic_results:
        return json['organic_results'];
    }
  }
}