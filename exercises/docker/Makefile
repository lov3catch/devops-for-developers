build:
	docker build . -t hexlet/fastify

test: setup build

# BEGIN
setup:
	docker build . -t lov3catch/fastify

run:
	docker run -it -p 3000:3000 lov3catch/fastify

# END
