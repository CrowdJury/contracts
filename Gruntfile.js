var fs = require('fs');

module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-contrib-concat');

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        concat: {
            options: {
                separator: ''
            },
            dist: {
                src: ['contracts/Evidence.sol','contracts/Person.sol','contracts/Entity.sol','contracts/Jugdment.sol'],
                dest: 'Crowdjury.sol'
            }
        },

    });

    grunt.registerTask('default', ['concat']);

};
