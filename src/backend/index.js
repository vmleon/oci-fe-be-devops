const express = require('express');
const Joke = require('awesome-dev-jokes');
const pino = require('pino-http')();
const app = express();
const port = process.env.PORT || 3000;

app.use(pino);

app.get('/joke', (req, res) => {
  res.json({joke: Joke.getRandomJoke()});
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
