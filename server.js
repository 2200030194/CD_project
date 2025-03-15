const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Hello, this is a Node.js app running in a Docker container!');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
