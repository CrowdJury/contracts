var fs = require('fs');
var solc = require('solc');
var exec = require('child_process').exec;

var contracts = ['./contracts/Owned.sol', './contracts/Entity.sol', './contracts/Evidence.sol', './contracts/Person.sol', './contracts/Judgment.sol'];

module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');

	const finalContractName = 'Crowdjury';

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        concat: {
            options: {
                separator: ''
            },
            dist: {
                src: contracts,
                dest: './Crowdjury.sol'
            }
        },

        watch: {
          contracts: {
            files: contracts,
            tasks: ['concat','compile']
          },
          options: {
            nospawn: true,
          }
        }

    });

    grunt.registerTask('compile', 'Compile contracts.', function() {
        if (process.platform == 'linux')
            exec("notify-send 'Compiling contracts..'");
        var done = this.async();
        fs.readFile(finalContractName+'.sol', function read(err, data) {
            if (err)
                throw err;
            console.log("Compiling...");
            compile(data, done);
        });

        function compile(data, done){
            var output = solc.compile(data.toString(), 1);
            if (output.errors){
                console.error("Errors:");
                for (var error in output.errors)
                	console.error(output.errors[0]);
                if (process.platform == 'linux')
                    exec("notify-send '"+output.errors.length+" Compilation error'");
                done();
            } else {
                for (var contractName in output.contracts)
                	console.log(contractName + ' compiled !');
                if (process.platform == 'linux')
                    exec("notify-send 'Compilation successfull'");
                done();
            }
        }
    });

    grunt.registerTask('default', ['concat','compile']);
	grunt.registerTask('build', ['concat','compile']);
    grunt.registerTask('dev', ['watch:contracts']);

};
