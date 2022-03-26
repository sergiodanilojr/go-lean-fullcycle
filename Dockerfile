FROM golang:1.8.3 AS build

WORKDIR /go/src/app

COPY *.go .

RUN go build -o /main

RUN go install
RUN ldd /go/bin/app | grep -q "not a dynamic executable"

# DEPLOY

FROM scratch

WORKDIR /
COPY --from=build /main /main

EXPOSE 8080

CMD [ "/main" ]