cd ~/my*
cp ch sm $PREFIX/bin
if command -v pip3;then
pip3 install -r requirements.txt --no-cache-dir
else
pp i -r ~/Ult*/req*  --no-cache-dir --force-reinstall
fi
for c in pillow coloredlogs gitpython bs4 pytz enhancer telegraph aiohttp requests; do
  msg "➤ Installing $c"
  ch "$c"
done