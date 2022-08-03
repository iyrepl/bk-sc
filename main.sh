
# rm -rf brook #Uncomment this line to update

if [ ! -f "brook" ];then
  curl -L https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64 -o brook
fi
chmod +x brook

./brook wsserver --listen :"$PORT" --password "$passwd"
