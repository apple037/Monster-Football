// require json-2-csv module
const converter = require('json-2-csv');
const fs = require('fs');

// read JSON from a file
var name = '../address_' + process.argv[2] + '.json';
const address = JSON.parse(fs.readFileSync(name));

// convert JSON array to CSV string
converter.json2csv(address, (err, csv) => {
    if (err) {
        throw err;
    }

    // print CSV string
    //console.log(csv);

    // write CSV to a file
    var csv_name = 'address_' + process.argv[2] + '.csv';
    fs.writeFileSync(csv_name, csv);
    
});