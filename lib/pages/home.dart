import 'package:aplikasi_journal_2/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_journal_2/models/journal_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState () => _HomeState();
}

class _HomeState extends State<Home> {
  
  FetchJournalList _journalList = FetchJournalList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text('Journal Mobile')
      ),
      body: Center(child: FutureBuilder<List<Journal>>(
        future: _journalList.getJournalData(),
        builder: (context, snapshot){
          var journal = snapshot.data;
          return ListView.builder(
            itemCount: journal?.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
              child: Text(journal![index].title),
              );
            },
          );
        }
        ),
      ),
    ));
  }
}