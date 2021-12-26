'use strict';

const request = require('request');

module.exports.webhook = (event, _context, callback) => {
  const token = process.env.BOT_TOKEN;
  const BASE_URL = `https://api.telegram.org/bot${token}/sendMessage`;

  const body = JSON.parse(event.body)
  const message = body.message
  const chatId = message.chat.id

  request.post(BASE_URL).form({ text: message.text, chat_id: chatId });

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      input: event,
    }),
  };

  return callback(null, response);

};
