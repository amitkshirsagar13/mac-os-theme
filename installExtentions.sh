#!/bin/bash

# Install Gnome Extensions

array=( blur-my-shell@aunetx dev-container-manager@devopsnextgenx monitor@astraext.github.io search-light@icedman.github.com CoverflowAltTab@palatis.blogspot.com gnome-ui-tune@itstime.tech quick-settings-tweaks@qwreey user-theme@gnome-shell-extensions.gcampax.github.com dash-to-dock@micxgx.gmail.com just-perfection-desktop@just-perfection Rounded_Corners@lennart-k )
# for i in "${array[@]}"
# do
#     echo $i
# done

# # array=( blur-my-shell@aunetx dev-container-manager@devopsnextgenx monitor@astraext.github.io search-light@icedman.github.com CoverflowAltTab@palatis.blogspot.com gnome-ui-tune@itstime.tech quick-settings-tweaks@qwreey user-theme@gnome-shell-extensions.gcampax.github.com dash-to-dock@micxgx.gmail.com just-perfection-desktop@just-perfection Rounded_Corners@lennart-k logomenu@aryan_k )

for i in "${array[@]}"
do
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${i}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${i}.zip "https://extensions.gnome.org/download-extension/${i}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${i}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
    fi
    gnome-extensions enable ${i}
    rm ${EXTENSION_ID}.zip
done