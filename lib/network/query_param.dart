class  QP {
  const  QP._();

  static Map<String, String> apiQp({
    required String engine,
    required String api_key,
    required String q,
    required String as_ylo,
    required String as_yhi,
    required String hl
    }) => {
     'engine': engine,
     'api_key': api_key,
     'q': q,
     'as_ylo': as_ylo,
     'as_yhi': as_yhi,
     'hl': hl
    };
}