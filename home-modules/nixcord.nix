# managed by home manager
{ inputs, ... }:

{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    config.plugins = {
      betterGifPicker.enable = true;
      betterRoleDot.enable = true;
      betterSettings.enable = true;
      betterUploadButton.enable = true;
      callTimer.enable = true;
      colorSighted.enable = true;
      disableCallIdle.enable = true;
      dontRoundMyTimestamps.enable = true;
      fakeNitro.enable = true;
      favoriteEmojiFirst.enable = true;
      favoriteGifSearch.enable = true;
      fixSpotifyEmbeds.enable = true;
      fixYoutubeEmbeds.enable = true;
      forceOwnerCrown.enable = true;
      friendsSince.enable = true;
      gameActivityToggle.enable = true;
      iLoveSpam.enable = true;
      imageZoom.enable = true;
      loadingQuotes.enable = true;
      memberCount.enable = true;
      mentionAvatars.enable = true;
      messageLatency.enable = true;
      moreCommands.enable = true;
      moreKaomoji.enable = true;
      noBlockedMessages.enable = true;
      noDevtoolsWarning.enable = true;
      noF1.enable = true;
      noProfileThemes.enable = true;
      noTypingAnimation.enable = true;
      permissionFreeWill.enable = true;
      petpet.enable = true;
      platformIndicators.enable = true;
      userMessagesPronouns.enable = true;
      readAllNotificationsButton.enable = true;
      relationshipNotifier.enable = true;
      roleColorEverywhere.enable = true;
      showHiddenChannels.enable = true;
      showHiddenThings.enable = true;
      silentTyping.enable = true;
      spotifyControls.enable = true;
      typingIndicator.enable = true;
      whoReacted.enable = true;
      youtubeAdblock.enable = true;
      
      showMeYourName = {
        enable = true;
        mode = "nick-user";
      };

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
