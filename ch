mkdir -p $PREFIX/tmp
cat > $PREFIX/bin/ch << 'EOF'
#!/bin/bash
T="${TMPDIR:-$PREFIX/tmp}"
mkdir -p "$T"

progress_bar() {
  local d=$1 w=30 i
  for ((i=0; i<=w; i++)); do
    f=$(printf "%${i}s" | tr ' ' '#')
    e=$(printf "%$((w-i))s")
    printf "\r[%s%s] %d%%" "$f" "$e" $((i*100/w))
    sleep "$d"
  done
  echo
}

run_bg() {
  "$@" >"$T/ch_log" 2>&1 &
  pid=$!
  while kill -0 $pid 2>/dev/null; do progress_bar 0.03; done
  wait $pid
}

for item in "$@"; do
  echo "-------------------"
  echo "Processing: $item"

  if command -v "$item" >/dev/null 2>&1; then
    echo "OK $item (command) already installed"; continue
  fi
  if python -c "import $item" 2>/dev/null; then
    echo "OK $item (python) already installed"; continue
  fi

  echo "> Trying pkg install: $item"
  if run_bg pkg install -y "$item"; then
    echo "OK $item installed via pkg"; continue
  fi

  echo "> Trying pip install: $item"
  if run_bg pip install "$item"; then
    echo "OK $item installed via pip"
  else
    echo "FAILED: $item"
    echo "Log: $T/ch_log"
  fi
done
EOF
chmod +x $PREFIX/bin/ch
