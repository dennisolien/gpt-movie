const express = require('express');
const { getMovieTitleFromQ } = require('./gpt');

const app = express();
const port = 3000;

app.get('/ping', (req, res) => {
	res.send('pong');
});

app.get('/movie/rec', async (req, res) => {
	const { q } = req.query;
	const text = await getMovieTitleFromQ(q);
	res.send(text);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});