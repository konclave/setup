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

curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Black.ttf -s -o ~/Library/Fonts/MonoLisa-Black.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-BlackItalic.ttf -s -o ~/Library/Fonts/MonoLisa-BlackItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Bold.ttf -s -o ~/Library/Fonts/MonoLisa-Bold.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-BoldItalic.ttf -s -o ~/Library/Fonts/MonoLisa-BoldItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-ExtraLight.ttf -s -o ~/Library/Fonts/MonoLisa-ExtraLight.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-ExtraLightItalic.ttf -s -o ~/Library/Fonts/MonoLisa-ExtraLightItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Light.ttf -s -o ~/Library/Fonts/MonoLisa-Light.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-LightItalic.ttf -s -o ~/Library/Fonts/MonoLisa-LightItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Medium.ttf -s -o ~/Library/Fonts/MonoLisa-Medium.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-MediumItalic.ttf -s -o ~/Library/Fonts/MonoLisa-MediumItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Regular.ttf -s -o ~/Library/Fonts/MonoLisa-Regular.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-RegularItalic.ttf -s -o ~/Library/Fonts/MonoLisa-RegularItalic.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-Thin.ttf -s -o ~/Library/Fonts/MonoLisa-Thin.ttf && \
curl https://raw.githubusercontent.com/okonet/Monolisa/refs/heads/master/MonoLisa-ThinItalic.ttf -s -o ~/Library/Fonts/MonoLisa-ThinItalic.ttf && \
echo '✅ Monolisa font downloaded' \
|| echo '❗️ Could not download Monolisa font';


sudo mdutil -i off -a \
	&& sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist \
	&& echo '✅ spotlight index turn off' \
	|| echo '❗️ spotlight index is running'    

# Install HomeBrew and software
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && brew install font-fira-code \
    && brew install iterm2 \
    && brew install only-switch \
    && brew install boop \
    && brew install bluesnooze \
    && brew install fork \
	&& brew install finicky \
	&& brew install calibre \
	&& brew install orbstack \
	&& brew install tailscale \
	&& brew install syncthing \
	&& brew install netnewswire \
	&& brew install languagetool-desktop \
	&& brew install bitwarden
	&& brew install lunar \
	&& brew install logseq \
	&& brew install colemak-dh \
	&& brew install shottr \
    && brew install maccy \
	&& brew install colemak-dh \
	&& brew install mise && echo 'eval "$(/opt/homebrew/bin/mise activate zsh)"' >> ~/.zshrc \
    && brew install starship \	
    && echo -e 'eval "$(starship init zsh)"' >> ~/.zshrc \
    && echo '✅ brew and software installation' \
	|| echo '❗️ brew and software installation failed'    

# Install Syncthing
brew install syncthing
cat <<'EOF' > ~/Library/LaunchAgents/com.user.syncthing.plist && launchctl load ~/Library/LaunchAgents/com.user.syncthing.plist && echo '✅ syncthing' || echo '❗️ syncthing installation failed'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Syncthing</key>
    <string>com.user.syncthing</string>

    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/syncthing</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/tmp/syncthing.out.log</string>

    <key>StandardErrorPath</key>
    <string>/tmp/syncthing.err.log</string>
</dict>
</plist>
EOF


echo ''
echo 'MacOS preparation is done'
