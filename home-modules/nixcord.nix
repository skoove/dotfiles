# managed by home manager
{ inputs, ... }:

{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    config.plugins = {
      colorSighted.enable = true;
      dontRoundMyTimestamps.enable = true;
      fakeNitro.enable = true;
      favoriteEmojiFirst.enable = true;
      favoriteGifSearch.enable = true;
      forceOwnerCrown.enable = true;
      friendsSince.enable = true;
      iLoveSpam.enable = true;
      imageZoom.enable = true;
      loadingQuotes.enable = true;
      memberCount.enable = true;
      noBlockedMessages.enable = true;
      noDevtoolsWarning.enable = true;
      noF1.enable = true;
      noProfileThemes.enable = true;
      noTypingAnimation.enable = true;
      permissionFreeWill.enable = true;
      petpet.enable = true;
      readAllNotificationsButton.enable = true;
      
      messageLogger = {
        enable = true;
        collapseDeleted = true;
      };

      betterFolders = {
        enable = true;
        closeAllFolders = true;
        closeAllHomeButton = true;
        closeOthers = true;
        forceOpen = true;
      };
    };
  };
}
