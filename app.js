const express = require('express')
const app = express()
const path = require('path');
const port = 3000
app.use(express.static('public'))

app.get('/', (req, res) => res.send('Hello World!'))

app.get('/yoyo',function(req,res) {
  res.sendFile(path.join('public/index.html'));
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`))