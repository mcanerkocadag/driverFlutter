part of '../home_view.dart';

class _PassiveChip extends StatelessWidget {
  const _PassiveChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        "label",
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
  const _ActiveChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        "active label",
        style: context.textTheme.bodySmall?.copyWith(
          color: ColorConstants.white,
        ),
      ),
      padding: context.paddingLow,
      backgroundColor: ColorConstants.purpleDark,
    );
  }
}
