#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# install xcode tools
xcode-select --install || echo 'xcode tools are already installed';

# Save screenshots in ~/Screenshots
[ ! -d ~/Screenshots ] && mkdir ~/Screenshots \
    && defaults write com.apple.screencapture location "$HOME"/Screenshots \
    && echo '✅ Screenshots will be saved to ~/Screenshots' \
    || echo '❗️ Could not save screenshots to ~/Screenshots';

# dock settings
defaults write com.apple.dock autohide = 1 \
    && defaults write com.apple.dock tilesize = 52 \
    && defaults write com.apple.dock show-recents = 0 \
    && echo '✅ Dock is set up' \
    || echo '❗️ Could not set up dock';

defaults write com.apple.Safari HomePage -string "about:blank" \
    && defaults write com.apple.Safari AutoOpenSafeDownloads -bool false \
    && defaults write com.apple.Safari ShowFavoritesBar -bool false \
    && defaults write com.apple.Safari ShowSidebarInTopSites -bool false \
    && defaults write com.apple.Safari IncludeDevelopMenu -int 1 \
    && defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true \
    && echo '✅ safari settings' \
    || echo '❗️ could not set up settings for safari';

# set Keyboard -> Shortcuts -> Use keyboard navigation to move focus between controls setting checked
defaults write "Apple Global Domain" AppleKeyboardUIMode 2 \ 
    && echo '✅ Keyboard navigation is set up' \
    || echo '❗️ Could not set up keyboard navigation';

sudo mdutil -i off -a \
	&& sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist \
	&& echo '✅ spotlight index turn off' \
	|| echo '❗️ spotlight index is running'    

# Install HomeBrew and software
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && brew tap homebrew/cask-versions \
    && brew tap homebrew/cask-fonts \
    && brew install --cask font-fira-code \
    && brew install --cask iterm2 \
    && brew install --cask keepingyouawake \
    && brew install --cask spectacle \
    && brew install --cask boop \
    && brew install --cask bluesnooze \
    && brew install --cask fork \
    && brew install --cask maccy \
	&& brew install --cask colemak-dh \
	&& brew install mise \
    && brew install starship \	
    && echo -e 'eval "$(starship init zsh)"' >> ~/.zshrc \
    && echo '✅ brew and software installation' \
	|| echo '❗️ brew and software installation failed'    

echo ''
echo 'MacOS preparation is done'
