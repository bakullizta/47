clear
echo "
47 installer test
";

if [ "$AFILE47" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$AFILE47/usr/share/doc/47"
    BIN_DIR="$AFILE47/bin/"
    BASH_PATH="$AFILE47/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "detektif47" ]; then
    INSTALL_DIR="/usr/local/47"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

else
    INSTALL_DIR="$HOME/.47"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory 47 was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/47*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/47*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi

echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/bakullizta" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/bakullizta"
    else
        sudo rm -rf "$ETC_DIR/bakullizta"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/bakullizta/47 "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/47.py" '${1+"$@"}' > "$INSTALL_DIR/47";
chmod +x "$INSTALL_DIR/47";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/47" "$BIN_DIR"
    cp "$INSTALL_DIR/47.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/47" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/47.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/47";

if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by detektif47 test !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
