part of '../home_view.dart';

class _PassiveChip extends StatelessWidget {
  const _PassiveChip(this.tag);
  final Tag? tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag?.name ?? '',
        style: context.textTheme.bodySmall?.copyWith(
          color: ColorConstants.grayPrimary,
        ),
      ),
      padding: context.paddingLow,
      backgroundColor: ColorConstants.grayLighter,
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip(this.tag);
  final Tag? tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tag?.name ?? '',
        style: context.textTheme.bodySmall?.copyWith(
          color: ColorConstants.white,
        ),
      ),
      padding: context.paddingLow,
      backgroundColor: ColorConstants.purpleDark,
    );
  }
}
