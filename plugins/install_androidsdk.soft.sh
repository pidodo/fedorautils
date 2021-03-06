# Name: Install Android SDK
# Command: install_androidsdk
# Value: False

install_androidsdk() {
show_func "Installing Android SDK"
if [[ "$(install_androidsdk_test)" = "Installed" ]]; then
	show_status "Android SDK already installed"
else
	source "$plugindir/install_jdk.soft.sh" && install_jdk
	show_msg "Fetching webpage..."
	get_file_quiet "http://developer.android.com/sdk/index.html" "index.html"
	get=$(grep "linux-sdk" index.html | tr " " "\n" | grep ".tgz" | cut -d\" -f 2 | head -n 1)
	file=${get##*/}
	get_file
	tar xvf "$file"
	mv android-sdk-linux /opt/
	chmod -R 775 "/opt/android-sdk-linux/"
fi
[[ "$(install_androidsdk_test)" = "Installed" ]]; exit_state
}

install_androidsdk_test() {
if [[ -d /opt/android-sdk-linux/ ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
