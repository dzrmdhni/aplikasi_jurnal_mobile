import 'dart:io';

import 'package:aplikasi_journal_2/models/journal_model.dart';
import 'package:aplikasi_journal_2/size_config.dart';
import 'package:aplikasi_journal_2/network/journal_api.dart';
import 'package:aplikasi_journal_2/widgets/viewer_widget.dart';
import 'package:flutter/material.dart';

class JournalWidget extends StatelessWidget{
  const JournalWidget({Key? key, required this.journal}) : super(key: key);

  final Journal journal;

  void openPDF(BuildContext context, File file, Journal journal) => Navigator.of(context).push( //Membuka viewer jurnal
    MaterialPageRoute(builder: (context) => JournalViewer(file: file, journal: journal))
    );

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
    final author = journal.publication_info.summary.split(' - ')[0];
    final year = journal.publication_info.summary.split(' - , ')[0];
    final publisher = journal.publication_info.summary.split(' - ')[2];
    return SizedBox(
      height: getProportionateScreenHeight(85),
      child: Card(
        color: Colors.grey[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ListTile(
          onTap: ()async{
            final jLink = journal.resources.link;
            final file = await PDFApi.loadNetwork(jLink);

            // ignore: use_build_context_synchronously
            openPDF(context, file, journal);
          },
        title: Text(journal.title, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(author, 
              style: TextStyle(color: Colors.blue[800]),
              overflow: TextOverflow.ellipsis
            ),
            Text(year,
              style: const TextStyle(color: Colors.black)),
            Text(publisher, overflow: TextOverflow.ellipsis)
            ]
          ),
        )
      ),
    );
  }
}