const axios = require('axios');

const ENV = process.env;
const KEY = ENV.OPEN_AI_KEY;
const baseUrl = 'https://api.openai.com/v1';

/**
 * Store the querys and the results in a db
 */

function moviePromptQuery(query) {
  // TODO: validate input.
  if(query.length > 60) {
      throw new Error('Query is to long');
  }
  const promptData = [
    {
        I: 'A movie about a hero, in a magical place. A battle between good and eval.',
        M: 'Harry Potter',
    },
    {
        I: 'Using science to solve problems, a trilling and exiting movie.',
        M: 'The Martian',
    },
    {
        I: 'Astronauts are going to the moon, when shit hits the fan',
        M: 'Apollo 13',
    },
    {
        I: 'A british romantic drama around christmas',
        M: 'Love Actually',
    },
    {
        I: 'No make sense, this line does, bad text no.',
        M: 'unknown',
    },
    {
        I: query,
        M: ''
    }
  ];

  const promptText = promptData.reduce((text, { I, M }) => {
    if (text.length !== 0 && M) {
      return `${text}\nI: ${I}\nM: ${M}`;
    }
    if (!M) {
      return `${text}\nI: ${I}\nM:`;
    }
    return `I: ${I}\nM: ${M}`;
  }, '');

  return promptText;
}

const moviePrompt = (prompt) => ({
  'prompt': prompt,
  'temperature': 0.7,
  'max_tokens': 64,
  'top_p': 1,
  'frequency_penalty': 0,
  'presence_penalty': 0,
  'stop': ['I:', 'M:']
});

const useEngine = (engine) => `${baseUrl}/engines/${engine}`;

const createHeaders = (key) => ({
  'Content-Type': 'application/json',
  'Authorization': `Bearer ${KEY}`,
})

async function completions(engine, headers, body) {
  const url = `${engine}/completions`;
  console.log('Sending gpt req')
  const res = await axios.post(url, body, {headers});
  return res.data;
}

function getResultText(aiResult) {
  if (aiResult.choices && aiResult.choices.length < 1) {
    console.log('More then one res:');
    console.log(aiResult);
  }

  if (aiResult.choices && aiResult.choices[0]) {
    return aiResult.choices[0].text || 'unknown';
  }
  return 'unknown';
}

async function getMovieTitleFromQ(q) {
  const prompt = moviePromptQuery(q);
  const body = moviePrompt(prompt);
  const engine = useEngine('davinci');
  const headers = createHeaders(KEY);
  const res = await completions(engine, headers, body);
  const resText = getResultText(res);

  return resText;
}

module.exports = {
  getMovieTitleFromQ,
};

// run('Robots are good');