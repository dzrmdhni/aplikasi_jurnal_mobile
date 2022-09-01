import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_journal_2/models/journal_model.dart';

class JournalViewer extends StatefulWidget {
  final File file;
  final Journal journal;

  const JournalViewer({
    Key? key,
    required this.file, required this.journal
  }) : super(key: key);

  @override
  JournalViewerPageState createState() => JournalViewerPageState();
  }

  class JournalViewerPageState extends State<JournalViewer>{
    late PDFViewController controller;

    int pages = 0;
    int indexPage = 0;

    @override
    Widget build(BuildContext context) {

      final name = widget.journal.title;
      final text = '${indexPage + 1} of $pages';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        pageSnap: false,
        pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
      floatingActionButton: citateButton(),
    );
  }
  
  Widget citateButton() => FloatingActionButton(
    backgroundColor: Colors.orange,
    child: const Icon(Icons.copy),
    onPressed: () {
      Clipboard.setData(ClipboardData(text:"${widget.journal.title}, ${widget.journal.publication_info}"))
      .then((_){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Journal Citated')));
      });
    },
  );
}