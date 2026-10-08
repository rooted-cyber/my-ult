cd ~/my*
cp ch sm $PREFIX/bin
chmod 777 ch sm
if command -v pip3;then
pip3 install -r requirements.txt --no-cache-dir
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

  pip install "$item" >/tmp/pip_log 2>&1 &
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
for c in pillow coloredlogs gitpython bs4 pytz enhancer telegraph aiohttp requests; do
  msg "➤ Installing $c"
  pp i "$c"
done
