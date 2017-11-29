curl http://localhost:8080/
curl http://localhost:8080/mixed

curl http://localhost:8080/basicauth -H 'Authorization: Basic LTEwMDAwMDoxMjM0NTY3ODkw'
curl http://localhost:8080/hello?dvid=2
curl http://localhost:8080/hello?dvid=1
curl http://localhost:8080/hello?dvid=3
curl http://localhost:8080/hello?dvid=4