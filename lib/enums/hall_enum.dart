enum Hall { hall1, hall2, hall3, hall4, hall5, hall6, hall7, hall8 }

List<Hall> halls = [Hall.hall1, Hall.hall2, Hall.hall3, Hall.hall4, Hall.hall5, Hall.hall6, Hall.hall7, Hall.hall8];

String getHallName(Hall hall) {
  switch (hall) {
    case Hall.hall1:
      return 'Hall 1';
    case Hall.hall2:
      return 'Hall 2';
    case Hall.hall3:
      return 'Hall 3';
    case Hall.hall4:
      return 'Hall 4';
    case Hall.hall5:
      return 'Hall 5';
    case Hall.hall6:
      return 'Hall 6';
    case Hall.hall7:
      return 'Hall 7';
    case Hall.hall8:
      return 'Hall 8';
  }
}

Hall getHallByName(String hall) {
  switch (hall) {
    case 'Hall 1':
      return Hall.hall1;
    case 'Hall 2':
      return Hall.hall2;
    case 'Hall 3':
      return Hall.hall3;
    case 'Hall 4':
      return Hall.hall4;
    case 'Hall 5':
      return Hall.hall5;
    case 'Hall 6':
      return Hall.hall6;
    case 'Hall 7':
      return Hall.hall7;
    case 'Hall 8':
      return Hall.hall8;
    default:
      return Hall.hall1;
  }
}
