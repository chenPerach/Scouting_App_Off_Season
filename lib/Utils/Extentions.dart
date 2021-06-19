extension SmartList on List {
  static List<T> fromIterable<T, E>(Iterable<E> iterable, T generator(E e)) {
    return List.generate(
        iterable.length, (index) => generator(iterable.elementAt(index)));
  }
}
