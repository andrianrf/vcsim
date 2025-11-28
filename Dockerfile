# Stage 1: Build vcsim
FROM golang:1.24 AS build
WORKDIR /go/src/app
COPY . .
RUN cd vcsim && go build -o vcsim

# Stage 2: Final image
FROM python:3.11-slim
COPY --from=build /go/src/app/vcsim /vcsim
EXPOSE 8989
ENTRYPOINT ["./vcsim/vcsim"]
CMD ["-l", "0.0.0.0:8989"]

# CMD ["sleep", "infinity"]