docker build -t dnsperf .

docker run --rm \
  -v "$(pwd)/queries.txt:/data/queries.txt" \
  dnsperf \
  -s 192.168.0.2 -p 53 \
  -d /data/queries.txt \
  -Q 2000 \
  -n 20000
