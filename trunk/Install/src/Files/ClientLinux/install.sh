#!/bin/bash
#
# Директория, в которую будет установлен клиент gccllin
#
echo -n "Enter install directory [/opt/gccllin]:"
read GC_DIR
if [ -z "$GC_DIR" ]; then
    GC_DIR=/opt/gccllin
fi
#
# Пользователь, под которым будет запускаться клиент gccllin
#
echo -n "Enter username for gameclass client [gameclass]:"
read GC_USER
if [ -z "$GC_USER" ]; then
    GC_USER=gameclass
fi

BINS="bg_exec gccllin"
LIBS="libborqt-6.9-qt2.3.so"
SKINS=`ls Skins`

#
# Устанавливаем клиента
#
install -d $GC_DIR
install -m 0755 $BINS $GC_DIR
install -m 0644 $LIBS $GC_DIR
pushd Skins > /dev/null
install -d $GC_DIR/Skins
install -m 644 $SKINS $GC_DIR/Skins
popd > /dev/null

#
# Создаем скрипт запуска клиента
#
cat > gccllin.sh << EOF
#!/bin/sh
cd $GC_DIR
LANG=ru_RU.CP1251 XAUTHORITY=/home/$GC_USER/.Xauthority DISPLAY=":0.0" LD_LIBRARY_PATH=$GC_DIR ./bg_exec ./gccllin > gc.log 2>&1 &
exit 0
EOF
install -m 0755 gccllin.sh $GC_DIR

#
# Создаем конфигурационный файл
#
cat > gccllin.ini << EOF
[Client]
KDEUser=$GC_USER
EOF
install -m 0644 gccllin.ini $GC_DIR

#
# Создаем локаль CP1251
#
localedef -c -i ru_RU -f CP1251 ru_RU.CP1251

#
# Изменяем rc.local для автоматического запуска клиента при старте системы
#
cat /etc/rc.local | grep "gccllin.sh" >/dev/null && exit 0
sed "s|^exit 0|$GC_DIR/gccllin.sh|g" /etc/rc.local > rc.local
echo "exit 0" >> rc.local
install -b -m 755 rc.local /etc/
