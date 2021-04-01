import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';

import 'BlocProvider.dart';


class NotesBloc implements BlocBase {
  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  final _notesController = StreamController<List<DoctorListResponseModel>>.broadcast();

  // Input stream. We add our notes to the stream using this variable.
  StreamSink<List<DoctorListResponseModel>> get _inNotes => _notesController.sink;

  // Output stream. This one will be used within our pages to display the notes.
  Stream<List<DoctorListResponseModel>> get notes => _notesController.stream;

  // Input stream for adding new notes. We'll call this from our pages.
  final _addNoteController = StreamController<DoctorListResponseModel>.broadcast();
  StreamSink<DoctorListResponseModel> get inAddNote => _addNoteController.sink;

  NotesBloc() {
    // Retrieve all the notes on initialization
    getNotes();

    // Listens for changes to the addNoteController and calls _handleAddNote on change
    _addNoteController.stream.listen(_handleAddNote);
  }

  // All stream controllers you create should be closed within this function
  @override
  void dispose() {
    _notesController.close();
    _addNoteController.close();
  }

  void getNotes() async {
    // Retrieve all the notes from the database
    List<DoctorListResponseModel> notes = await DBProvider.db.getNotes();

    // Add all of the notes to the stream so we can grab them later from our pages
    _inNotes.add(notes);
  }

  void _handleAddNote(DoctorListResponseModel note) async {
    // Create the note in the database
    await DBProvider.db.newNote(note);

    // Retrieve all the notes again after one is added.
    // This allows our pages to update properly and display the
    // newly added note.
    getNotes();
  }
}