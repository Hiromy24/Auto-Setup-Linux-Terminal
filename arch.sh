set -euo pipefail

sudo pacman -Syu --noconfirm

sudo sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8

sudo pacman -S --noconfirm --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si --noconfirm
cd ~
rm -rf ~/yay

pacman_packages=(
	ghostty lf neovim rofi stow

	zsh
)
aur_packages=(
	wl-kbptr

	pokemon-colorscripts-git
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
yay -S --noconfirm "${aur_packages[@]}"

git clone --depth 1 https://github.com/Hiromy24/Dotfiles ~/dotfiles
cd ~/dotfiles
stow -t ~ .
cd ~

echo "shell"
ZSH_PATH="$(which zsh)"
grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
chsh -s "$ZSH_PATH"
