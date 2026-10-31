# Ultroid - UserBot
# Copyright (C) 2021-2026 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY install.sh .

RUN bash instlll.sh

# changing workdir
WORKDIR "/root/TeamUltroid"a


# start the bot.
CMD ["bash", "startup"]
