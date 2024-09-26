const express = require('express')
const app = express();
app.get('/', (_, res) => res.send(`Hello World ${process.env.MY_SECRET_1}`))
app.listen(3000, () => console.log('Server ready'))