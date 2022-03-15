class NavBarConfigId {
  final String _value;

  const NavBarConfigId(this._value);

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! NavBarConfigId) return false;
    return _value == other._value;
  }

  @override
  String toString() => 'NavBarConfigId: $_value';
}
