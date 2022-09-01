import 'package:aplikasi_journal_2/models/service_model.dart';
import 'package:aplikasi_journal_2/models/static_model.dart';
import 'package:aplikasi_journal_2/network/network_enums.dart';
import 'package:aplikasi_journal_2/network/network_helper.dart';
import 'package:aplikasi_journal_2/network/network_service.dart';
import 'package:aplikasi_journal_2/size_config.dart';
import 'package:aplikasi_journal_2/widgets/journal_widget.dart';
import 'package:aplikasi_journal_2/models/journal_model.dart';
import 'package:aplikasi_journal_2/widgets/search_widget.dart';

import 'package:flutter/material.dart';
import '../network/query_param.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  SearchState createState () => SearchState();
}

class SearchState extends State<Search> {
  
  FetchJournalList journalList = FetchJournalList();

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text('Journal Mobile')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        children: [
          FutureBuilder(
          future: getData(),
          builder: ((context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){

              final List<Journal> journal = snapshot.data as List<Journal>;

              return ListView.builder(
                itemBuilder: (context, index) {
                  return JournalWidget(journal: journal[index]);
                },
                itemCount: journal.length,
              );
            }else if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 25
                    ),
                    SizedBox(height: 10,),
                    Text('Terjadi kesalahan')
                  ],
                )
              );
            }
            return const Center(child: CircularProgressIndicator());
          })
        ,)
        ]
      ,) ,) 
      )
    );
  }

  Future<List<Journal>?> getData() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get, 
        url: StaticValues.apiUrl,
      queryParam: QP.apiQp(
        engine: StaticValues.apiEngine,
        api_key: StaticValues.apiKey,
        q: StaticValues.apiKeyword,
        as_ylo: StaticValues.yearFrom,
        as_yhi: StaticValues.yearTo,
        hl: StaticValues.apiLang
        )
    );

    print(response?.statusCode);

    return await NetworkHelper.filterResponse(
      callBack: _listOfJournalsFromJson,
      response: response,
      parameterName: CallBackParameterName.organic_results, 
      onFailureCallBackWithMessage: (errorType, msg){
        print('Error Code-$errorType - Message $msg');
        return null;
      }
    );
  }

  List<Journal> _listOfJournalsFromJson(json) => (json as List)
    .map((e) => Journal.fromJson(e as Map<String, dynamic>))
    .toList();
}