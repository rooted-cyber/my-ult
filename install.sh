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
pip3 install -r requirements.txt --no-cache-dir > /dev/null 2>&1

for c in pillow coloredlogs gitpython bs4 pytz enhancer request scatbox-uploader "cloudscraper>=1.2.7" aiohttp requests; do
  msg "➤ Installing $c"
  ch "$c"
done
