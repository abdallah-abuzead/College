enum Entry { entry1, entry2, entry3, entry4 }

List<Entry> entries = [Entry.entry1, Entry.entry2, Entry.entry3, Entry.entry4];

String getEntryName(Entry entry) {
  switch (entry) {
    case Entry.entry1:
      return 'Entry 1';
    case Entry.entry2:
      return 'Entry 2';
    case Entry.entry3:
      return 'Entry 3';
    case Entry.entry4:
      return 'Entry 4';
  }
}

Entry getEntryByName(String entry) {
  switch (entry) {
    case 'Entry 1':
      return Entry.entry1;
    case 'Entry 2':
      return Entry.entry2;
    case 'Entry 3':
      return Entry.entry3;
    case 'Entry 4':
      return Entry.entry4;
    default:
      return Entry.entry1;
  }
}
