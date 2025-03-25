{ ... }:
{
  programs.thunderbird = {
    enable = true;

    profiles.zie = {
      isDefault = true;
    };
  };
}
