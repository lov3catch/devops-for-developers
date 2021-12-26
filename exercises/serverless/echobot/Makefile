set-webhook:
	curl --request POST --url https://api.telegram.org/bot$(BOT_TOKEN)/setWebhook \
	--header 'content-type: application/json' --data '{"url": "$(URL)"}'

install:
	npm install

deploy:
	serverless deploy
