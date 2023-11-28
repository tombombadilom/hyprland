#!/usr/bin/env bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# shellcheck disable=SC1091
source "$HOME"/.cargo/env
sudo apt install -y libgtk-3-dev libgdk-3-dev libpango1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev
git clone https://github.com/Kirottu/anyrun.git anyrun
# shellcheck disable=SC2164
cd anyrun
cargo build --release
cargo install --path anyrun/ -y
mkdir -p ~/.config/anyrun/plugins
cp target/release/*.so ~/.config/anyrun/plugins
cp examples/config.ron ~/.config/anyrun/config.ron
rustup self uninstall -y
cd ../
rm -rf anyrun