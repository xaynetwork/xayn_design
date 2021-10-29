class TooltipKey {
  final String value;

  const TooltipKey(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TooltipKey && value == value;

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
