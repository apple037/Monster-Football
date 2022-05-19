const http = require('http')
const options = {
  hostname: 'localhost',
  port: 7003,
  path: '/client/contact/abi',
  method: 'GET'
}

const req = request(options, res => {
  console.log('status code: ${res.statusCode}')

  res.on('data', d => {
    process.stdout.write(d)
  })
})

req.on('error', error => {
  console.error(error)
})

req.end()