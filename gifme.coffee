readline = require 'readline'
http = require 'http'
asciimo = require('./node_modules/asciimo/lib/asciimo').Figlet
colors = require('./node_modules/asciimo/lib/colors')
copypaste = require 'copy-paste'

key = "dc6zaTOxFJmzC"
url = "http://api.giphy.com/v1/gifs/random?api_key=#{key}"

rl = readline.createInterface
  input: process.stdin,
  output: process.stdout

# Some random emotions
feelings = [
    "happy"
    "sad"
    "excited"
    "angry"
    "lazy"
    "confused"
    "bored"
    "interested"
]

# Get a random feeling
feeling = feelings[Math.floor(Math.random() * feelings.length)]

asciimo.write "gifME", "isometric2", (art) ->
    # Log art
    console.log art.green

    rl.question "What are you feeling? eg. #{feeling} ", (a) ->
        if !a
            a = feeling

        # Load up data
        url = "#{url}&tag=#{a}"

        http.get url, (res) ->
            res.setEncoding 'utf8'
            str = ""

            res.on 'data', (chunk) ->
                str += chunk

            res.on 'end', ->
                # Parse JSON
                json = JSON.parse str
                img = json.data.image_original_url

                # Copy image url
                copy img, ->
                    asciimo.write "Copied!", "banner3", (art) ->
                        console.log "\n#{art.green}"

                        # Close readline
                        rl.close()
