#!/bin/sh

# Файл, в который будут сохраняться команды
OUTFILE="../apply-scripts/dhcp_pool_192.168.20.xx.sh"

# Генерация команд для DHCP host-записей
echo "# Добавление новых host_20_* записей" >> "$OUTFILE"

for i in $(seq 1 99); do
  host_str=$(printf "%02d" "$i")
  section="host_20_$host_str"
  hostname="host-20-$host_str"
  mac="00:00:00:00:20:$host_str"
  ip="192.168.20.$i"

  echo "uci set dhcp.$section=host" >> "$OUTFILE"
  echo "uci set dhcp.$section.name='$hostname'" >> "$OUTFILE"
  echo "uci set dhcp.$section.mac='$mac'" >> "$OUTFILE"
  echo "uci set dhcp.$section.ip='$ip'" >> "$OUTFILE"
done

echo "" >> "$OUTFILE"
echo "# Применение изменений" >> "$OUTFILE"
echo "uci commit dhcp" >> "$OUTFILE"

# Сделать файл исполняемым
chmod +x "$OUTFILE"

echo "✅ Команды сохранены в $OUTFILE"