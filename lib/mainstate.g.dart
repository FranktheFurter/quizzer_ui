// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainstate.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainState on _MainStateBase, Store {
  Computed<ObservableList<WordNumberMatch>>? _$matchesToDisplayComputed;

  @override
  ObservableList<WordNumberMatch> get matchesToDisplay =>
      (_$matchesToDisplayComputed ??= Computed<ObservableList<WordNumberMatch>>(
              () => super.matchesToDisplay,
              name: '_MainStateBase.matchesToDisplay'))
          .value;

  late final _$numberAtom =
      Atom(name: '_MainStateBase.number', context: context);

  @override
  int get number {
    _$numberAtom.reportRead();
    return super.number;
  }

  @override
  set number(int value) {
    _$numberAtom.reportWrite(value, super.number, () {
      super.number = value;
    });
  }

  late final _$wordAtom = Atom(name: '_MainStateBase.word', context: context);

  @override
  String get word {
    _$wordAtom.reportRead();
    return super.word;
  }

  @override
  set word(String value) {
    _$wordAtom.reportWrite(value, super.word, () {
      super.word = value;
    });
  }

  @override
  String toString() {
    return '''
number: ${number},
word: ${word},
matchesToDisplay: ${matchesToDisplay}
    ''';
  }
}
