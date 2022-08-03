
# rm -rf brook_linux_amd64 #Uncomment this line to update

if [ ! -f "brook_linux_amd64" ];then
  curl -L https://github.com/txthinking/brook/releases/latest/download/brook_linux_amd64
fi
chmod +x brook_linux_amd64

./brook_linux_amd64 wsserver --listen :"$PORT" --password "$passwd"
