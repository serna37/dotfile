
# dotfiles
<a href="https://github.com/serna37/dotfiles/blob/master/.zshrc">
    <img src="http://img.shields.io/badge/zsh-5.9_x86_64-82f07a.svg?logo=zsh&logoColor=0000cd&labelColor=a3a3a3&style=popout">
</a>
<a href="https://github.com/serna37/dotfiles/blob/master/.vimrc">
    <img src="http://img.shields.io/badge/vim-9.0-019733.svg?logo=vim&logoColor=019733&labelColor=dedede&style=flat">
</a>

## Installation
- `Homebrew`を入れる
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- このレポジトリでの設定を適用する
```shell
INSTALL_FILES=( brew.sh brew-cask.sh install.sh )
for v in ${INSTALL_FILES[@]}; do
    curl -fsSL https://raw.githubusercontent.com/serna37/dotfiles/master/${v} | sh
done && exec $SHELL -l
```

## 関連レポジトリ
- [serna37/library](https://github.com/serna37/library)
(`install.sh`からcloneし設定されます)

## dotfiles構成
<!-- file tree -->
<a href="https://tree.nathanfriend.io/">
  <img src="https://img.shields.io/badge/file-tree-lightgray.svg?logo=files&style=flat">
</a>

```
.
├── conf/
│   ├── cpp/      : C++用設定ファイル デバッグ、フォーマット設定等
│   ├── vim/      : vimrcに付随した設定ファイル群
│   └── zsh/      : zshrcに付随した設定ファイル群
├── snippets/     : C++用スニペット
│
├── .vimrc        : vim設定
├── .zshrc        : zsh設定
│
├── brew.sh       : brew installするもの
├── brew-cask.sh  : brew install --caskするもの
└── install.sh    : 本レポジトリcloneや各設定の導入
```

---

> [!Note]
> - コードの署名: [参考](https://blog.symdon.info/posts/1610113408/)
> - Finderのキルを有効化するコマンド
> ```
> defaults write com.apple.Finder QuitMenuItem -boolean true
> ```
