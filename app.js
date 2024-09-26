const express = require('express')
const app = express();
app.get('/', (_, res) => res.send(`Hello World ${process.env.LAST_TEST}`))
app.listen(3000, () => console.log('Server ready'))