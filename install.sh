command -v msg || bash -c "$(curl -fsSl https://gist.githubusercontent.com/rooted-cyber/ce6248bd681844d35a12bd210989eb89/raw/install)"
cd ~
if [ -e my-ult ];then
msg already clne
else
msg cloning ultroid
git clone https://github.com/rooted-cyber/my-ult > /dev/null 2>&1
fi
cd ~/my*
cp ch sm $PREFIX/bin
chmod 777 $PREFIX/bin/ch $PREFIX/bin/sm
if command -v pip3;then
pip3 install -r requirements.txt --no-cache-dir > /dev/null 2>&1
else
pp i -r ~/my*/req*  --no-cache-dir --force-reinstall
fi
chh() {
#!/bin/bash

# progress bar
progress_bar() {
    local duration=$1
    local width=30
    local i

    for ((i=0; i<=width; i++)); do
        percent=$(( i * 100 / width ))
        filled=$(printf "%${i}s" | tr ' ' '█')
        empty=$(printf "%$((width-i))s")
        printf "\r[%s%s] %d%%" "$filled" "$empty" "$percent"
        sleep "$duration"
    done
    echo
}

for item in "$@"; do

  echo "━━━━━━━━━━━━━━━━━━━"
  echo "Processing: $item"

  # 1. Check if command exists
  if command -v "$item" >/dev/null 2>&1; then
    echo "✔ $item (shell command) already installed"
    continue
  fi

  # 2. Check if python package exists
  python -c "import $item" 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "✔ $item (python package) already installed"
    continue
  fi

  # 3. Try installing as system package
  echo "➤ Trying pkg install: $item"

  pkg install -y "$item" >/tmp/pkg_log 2>&1 &
  pid=$!

  while kill -0 $pid 2>/dev/null; do
      progress_bar 0.03
  done

  wait $pid

  if [ $? -eq 0 ]; then
    echo "✔ $item installed via pkg"
    continue
  fi

  # 4. Try installing as pip package
  echo "➤ Trying pip install: $item"

  pp i "$item"
  pid=$!

  while kill -0 $pid 2>/dev/null; do
      progress_bar 0.03
  done

  wait $pid

  if [ $? -eq 0 ]; then
    echo "✔ $item installed via pip"
  else
    echo "✘ Failed to install $item"
  fi

done
}
for c in pillow coloredlogs gitpython bs4 pytz enhancer request scatbox-uploader cloudscraper>=1.2.7 aiohttp requests; do
  msg "➤ Installing $c"
  ch "$c"
done
