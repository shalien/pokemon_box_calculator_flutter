
import 'package:pokemon_box_calc/src/pokemon_manager.dart';

int boxSize = 30;
List<int> oldGenTable = <int>[4, 5];
List<int> newGenTable = <int>[6, 5];


String getPokemonName(int index) {
    return PokemonManager().pokemons[index]!;
}

int getBox(int index) => (index / boxSize).ceilToDouble().toInt();


int getPosition(index) => index % boxSize == 0 ? 30 : index % boxSize;

String getGrid(index) {

  late int x, y;

  switch (boxSize) {
    case 30:
      x = newGenTable.first;
      y = newGenTable.last;
      break;
    case 20:
      x = oldGenTable.first;
      y = oldGenTable.last;
      break;
  }

  int caseIndex = 1;
  int position = getPosition(index);
  StringBuffer outputBuffer = StringBuffer();
  for (int lines = 0; lines < y; lines++) {
    for (int columns = 0; columns < x; columns++) {
      String symbol = caseIndex == position ? 'x' : '_';

      outputBuffer.write(' [ $symbol ] ');
      caseIndex++;
    }
    outputBuffer.write('\n');
  }
  return outputBuffer.toString();
}