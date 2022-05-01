part of 'darktheme_cubit.dart';

abstract class DarkthemeState extends Equatable {
  final bool isDark;

  Map<String, dynamic> toMap() {
    return {
      'isDark': isDark,
    };
  }

  String toJson() => json.encode(toMap());

  const DarkthemeState(this.isDark);
}

class DarkthemeChanged extends DarkthemeState {
  const DarkthemeChanged(bool isDark) : super(isDark);

  @override
  List<Object> get props => [isDark];
}
