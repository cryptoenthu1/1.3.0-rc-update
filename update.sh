sed -i 's/0x88B3D0Bfb8F207292Dc4Cee7C923d0E7C3078a18/0x8117632eC1D514550b3880Bc68F9AC1A76c9C67B/g' $HOME/keep-client/config/config.toml
sleep 1
sed -i 's/0xa5018dbeB6920A04e0CFd3D8F0F45BC851838b0D/0xd83248e311DC2Ba0d2A051e86f0678d8857f6ADD/g' $HOME/keep-client/config/config.toml
sleep 1
sed -i 's/0x9233Fd6C58e37dab223EF1dFD5e33eD69FD1f93b/0xf417b31104631280adF9F6828ee19985BC299fdC/g' $HOME/keep-client/config/config.toml
sleep 1
sed -i 's/0xe7BF8421fBE80c3Bf67082370D86C8D81D1D77F4/0xb37c8696cD023c11357B37b5b12A9884c9C83784/g' $HOME/keep-ecdsa/config/config.toml
sleep 1
sed -i 's/0x14dC06F762E7f4a756825c1A1dA569b3180153cB/0x9F3B3bCED0AFfe862D436CB8FF462a454040Af80/g' $HOME/keep-ecdsa/config/config.toml
sleep 1
docker stop keep-client ecdsa
sleep 2
docker rm keep-client ecdsa
sleep 2
sudo docker run -dit \
--restart always \
--volume $HOME/keep-client:/mnt \
--env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
--env LOG_LEVEL=debug \
--name keep-client \
-p 3919:3919 \
keepnetwork/keep-client:v1.3.0-rc --config /mnt/config/config.toml start
sleep 2
sudo docker run -d \
  --restart always \
  --entrypoint /usr/local/bin/keep-ecdsa \
  --volume $HOME/keep-ecdsa:/mnt/keep-ecdsa \
  --env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
  --env LOG_LEVEL=debug \
  --name ecdsa \
  -p 3920:3919 \
  keepnetwork/keep-ecdsa-client:v1.2.0-rc \
  --config /mnt/keep-ecdsa/config/config.toml start
sleep 2
