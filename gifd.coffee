readline = require 'readline'
http = require 'http'
asciimo = require('./node_modules/asciimo/lib/asciimo').Figlet
colors = require('./node_modules/asciimo/lib/colors')
copypaste = require 'copy-paste'

key = "VAa2AVeWXThiu2qD"
url = "http://api.gifme.io/v1/gifs/random?key=#{key}"

# Get arguments
args = process.argv

next = false
feeling = ""
# Get the arguments after gifme
args.forEach (val) ->
    if next is false
        next = true if val.indexOf("gifd") >= 0
    else
        feeling = val

fetchGif = (callback) ->
    http.get url, (res) ->
        res.setEncoding 'utf8'
        str = ""

        res.on 'data', (chunk) ->
            str += chunk

        res.on 'end', ->
            # Parse JSON
            json = JSON.parse str
            img = json.gif.gif

            # Copy image url
            copy img, ->
                asciimo.write "Copied!", "banner3", (art) ->
                    console.log "\n#{art.green}"

                    if callback
                        # Run callback
                        callback()

asciimo.write "gifD", "isometric2", (art) ->
    # Log art
    console.log art.green

    if feeling is ""
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

        rl.question "What are you feeling? eg. #{feeling} ", (a) ->
            if !a
                a = feeling

            # Load up data
            url = "#{url}&term=#{a}"

            fetchGif ->
                rl.close()
    else
        url = "#{url}&term=#{feeling}"
        fetchGif()
