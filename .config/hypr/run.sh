#!/bin/bash

# المسار المطلق للصورة
WP="/home/snorpiii/Documents/books/wp8958647-dark-souls-4k-wallpapers.jpg"
CONF="$HOME/.config/hypr/hyprpaper.conf"

# 1. قتل العمليات القديمة ونظافة البيئة
killall hyprpaper 2>/dev/null
sleep 0.5

# 2. توليد ملف الإعدادات الأساسي
echo "ipc = on" > "$CONF"
echo "preload = $WP" >> "$CONF"

# 3. تشغيل hyprpaper في الخلفية وتجاهل مخرجاتها
hyprpaper & 

# 4. انتظار بسيط لضمان تشغيل الـ Socket الخاص بـ IPC
sleep 1

# 5. جلب الشاشات وتعيين الخلفية قسرياً لكل شاشة مكتشفة
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

for MON in $MONITORS; do
    # تحميل الصورة في الذاكرة (Redundant for safety)
    hyprctl hyprpaper preload "$WP" 2>/dev/null
    # تعيين الخلفية قسرياً للشاشة المحددة
    hyprctl hyprpaper wallpaper "$MON,$WP"
done
