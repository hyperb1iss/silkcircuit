local M = {}

local TEMPLATE = [[
# LS_COLORS source for GNU dircolors.
# Copyright (C) 1996-2024 Free Software Foundation, Inc.
# Copying and distribution of this file, with or without modification,
# are permitted provided the copyright notice and this notice are preserved.

COLORTERM ?*
TERM Eterm
TERM ansi
TERM *color*
TERM con[0-9]*x[0-9]*
TERM cons25
TERM console
TERM cygwin
TERM *direct*
TERM dtterm
TERM gnome
TERM hurd
TERM jfbterm
TERM konsole
TERM kterm
TERM linux
TERM linux-c
TERM mlterm
TERM putty
TERM rxvt*
TERM screen*
TERM st
TERM terminator
TERM tmux*
TERM vt100
TERM xterm*

RESET 0
DIR 01;${ansi.purple}
LINK 01;${ansi.cyan}
MULTIHARDLINK 00
FIFO ${ansi.bg_bg};${ansi.yellow}
SOCK 01;${ansi.coral}
DOOR 01;${ansi.coral}
BLK ${ansi.bg_bg};${ansi.yellow};01
CHR ${ansi.bg_bg};${ansi.yellow};01
ORPHAN ${ansi.bg_bg};${ansi.red};01
MISSING 00
SETUID ${ansi.bg};${ansi.bg_red}
SETGID ${ansi.bg};${ansi.bg_yellow}
CAPABILITY 00
STICKY_OTHER_WRITABLE ${ansi.bg};${ansi.bg_green}
OTHER_WRITABLE ${ansi.bg};${ansi.bg_green}
STICKY ${ansi.bg};${ansi.bg_purple}
EXEC 01;${ansi.green}

# Archives and compressed files
.7z  01;${ansi.red}
.ace 01;${ansi.red}
.alz 01;${ansi.red}
.apk 01;${ansi.red}
.arc 01;${ansi.red}
.arj 01;${ansi.red}
.bz  01;${ansi.red}
.bz2 01;${ansi.red}
.cab 01;${ansi.red}
.cpio 01;${ansi.red}
.crate 01;${ansi.red}
.deb 01;${ansi.red}
.drpm 01;${ansi.red}
.dwm 01;${ansi.red}
.dz  01;${ansi.red}
.ear 01;${ansi.red}
.egg 01;${ansi.red}
.esd 01;${ansi.red}
.gz  01;${ansi.red}
.jar 01;${ansi.red}
.lha 01;${ansi.red}
.lrz 01;${ansi.red}
.lz  01;${ansi.red}
.lz4 01;${ansi.red}
.lzh 01;${ansi.red}
.lzma 01;${ansi.red}
.lzo 01;${ansi.red}
.pyz 01;${ansi.red}
.rar 01;${ansi.red}
.rpm 01;${ansi.red}
.rz  01;${ansi.red}
.sar 01;${ansi.red}
.swm 01;${ansi.red}
.t7z 01;${ansi.red}
.tar 01;${ansi.red}
.taz 01;${ansi.red}
.tbz 01;${ansi.red}
.tbz2 01;${ansi.red}
.tgz 01;${ansi.red}
.tlz 01;${ansi.red}
.txz 01;${ansi.red}
.tz  01;${ansi.red}
.tzo 01;${ansi.red}
.tzst 01;${ansi.red}
.udeb 01;${ansi.red}
.war 01;${ansi.red}
.whl 01;${ansi.red}
.wim 01;${ansi.red}
.xz  01;${ansi.red}
.z   01;${ansi.red}
.zip 01;${ansi.red}
.zoo 01;${ansi.red}
.zst 01;${ansi.red}

# Images and video
.avif 01;${ansi.coral}
.jpg 01;${ansi.coral}
.jpeg 01;${ansi.coral}
.mjpg 01;${ansi.coral}
.mjpeg 01;${ansi.coral}
.gif 01;${ansi.coral}
.bmp 01;${ansi.coral}
.pbm 01;${ansi.coral}
.pgm 01;${ansi.coral}
.ppm 01;${ansi.coral}
.tga 01;${ansi.coral}
.xbm 01;${ansi.coral}
.xpm 01;${ansi.coral}
.tif 01;${ansi.coral}
.tiff 01;${ansi.coral}
.png 01;${ansi.coral}
.svg 01;${ansi.coral}
.svgz 01;${ansi.coral}
.mng 01;${ansi.coral}
.pcx 01;${ansi.coral}
.mov 01;${ansi.coral}
.mpg 01;${ansi.coral}
.mpeg 01;${ansi.coral}
.m2v 01;${ansi.coral}
.mkv 01;${ansi.coral}
.webm 01;${ansi.coral}
.webp 01;${ansi.coral}
.ogm 01;${ansi.coral}
.mp4 01;${ansi.coral}
.m4v 01;${ansi.coral}
.mp4v 01;${ansi.coral}
.vob 01;${ansi.coral}
.qt  01;${ansi.coral}
.nuv 01;${ansi.coral}
.wmv 01;${ansi.coral}
.asf 01;${ansi.coral}
.rm  01;${ansi.coral}
.rmvb 01;${ansi.coral}
.flc 01;${ansi.coral}
.avi 01;${ansi.coral}
.fli 01;${ansi.coral}
.flv 01;${ansi.coral}
.gl 01;${ansi.coral}
.dl 01;${ansi.coral}
.xcf 01;${ansi.coral}
.xwd 01;${ansi.coral}
.yuv 01;${ansi.coral}
.cgm 01;${ansi.coral}
.emf 01;${ansi.coral}
.ogv 01;${ansi.coral}
.ogx 01;${ansi.coral}

# Audio
.aac 00;${ansi.cyan}
.au 00;${ansi.cyan}
.flac 00;${ansi.cyan}
.m4a 00;${ansi.cyan}
.mid 00;${ansi.cyan}
.midi 00;${ansi.cyan}
.mka 00;${ansi.cyan}
.mp3 00;${ansi.cyan}
.mpc 00;${ansi.cyan}
.ogg 00;${ansi.cyan}
.ra 00;${ansi.cyan}
.wav 00;${ansi.cyan}
.oga 00;${ansi.cyan}
.opus 00;${ansi.cyan}
.spx 00;${ansi.cyan}
.xspf 00;${ansi.cyan}

# Backups and temporary files
*~ 00;${ansi.purple_muted}
*# 00;${ansi.purple_muted}
.bak 00;${ansi.purple_muted}
.crdownload 00;${ansi.purple_muted}
.dpkg-dist 00;${ansi.purple_muted}
.dpkg-new 00;${ansi.purple_muted}
.dpkg-old 00;${ansi.purple_muted}
.dpkg-tmp 00;${ansi.purple_muted}
.old 00;${ansi.purple_muted}
.orig 00;${ansi.purple_muted}
.part 00;${ansi.purple_muted}
.rej 00;${ansi.purple_muted}
.rpmnew 00;${ansi.purple_muted}
.rpmorig 00;${ansi.purple_muted}
.rpmsave 00;${ansi.purple_muted}
.swp 00;${ansi.purple_muted}
.tmp 00;${ansi.purple_muted}
.ucf-dist 00;${ansi.purple_muted}
.ucf-new 00;${ansi.purple_muted}
.ucf-old 00;${ansi.purple_muted}
]]

local function sgr(prefix, rgb)
  return string.format("%d;2;%d;%d;%d", prefix, rgb.r, rgb.g, rgb.b)
end

function M.generate(colors)
  local ansi = {}
  for _, role in ipairs({
    "bg",
    "fg",
    "purple",
    "cyan",
    "coral",
    "yellow",
    "red",
    "green",
    "purple_muted",
  }) do
    ansi[role] = sgr(38, colors.rgb[role])
    ansi["bg_" .. role] = sgr(48, colors.rgb[role])
  end

  local variables = vim.tbl_extend("force", colors, { ansi = ansi })
  return require("silkcircuit.extra").template(TEMPLATE, variables)
end

return M
