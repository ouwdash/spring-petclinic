# get image
idc=$(docker ps -q)
# stop
docker stop $idc
# rm
docker rm $idc
