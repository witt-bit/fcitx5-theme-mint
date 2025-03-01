#!/usr/bin/env bash

SCRIPT_PATH=$(realpath "$0")
# 获取脚本所在目录的路径
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -h, --help    Display help message"
  echo "  -f, --force   Force install"
}

FORCE=0;
link_or_install=0;
# 解析每一个参数选项, 结合shift命令
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -f|--force)
      FORCE=1
      shift
      ;;
    -l|--link)
      link_or_install=1
      shift
      ;;
    *)
		echo -e "\033[31mUnknown option: $1\033[0m";
		usage
		exit 1
      ;;
  esac
done


install_theme() {
    local theme_dir_name="$1";
    if [ -d "/usr/share/fcitx5/themes/${theme_dir_name}" ]; then
        if [ ${FORCE} -eq 1 ]; then
            sudo rm -rf "/usr/share/fcitx5/themes/${theme_dir_name}"
        else
            echo -e "\033[31m/usr/share/fcitx5/themes/mint-blue-dark already exists, use -f to force install\033[0m"
            exit 1
        fi
    fi

    if [ ${link_or_install} -eq 0 ]; then
        sudo cp -r "${SCRIPT_DIR}/${theme_dir_name}" "/usr/share/fcitx5/themes/";
        echo -e "\033[32m${theme_dir_name} installed.\033[0m";
        return 0;
    fi

    sudo ln -s "${SCRIPT_DIR}/${theme_dir_name}" "/usr/share/fcitx5/themes/";
    echo -e "\033[32m${theme_dir_name} linked.\033[0m";
}

install_themes() {
    install_theme "$1-dark";
    install_theme "$1-light";
}


install_themes "mint-blue"
install_themes "mint-green"
