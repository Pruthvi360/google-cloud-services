gcloud auth list

gcloud config list project

gcloud iam service-accounts create pruthvi-text-to-speech

gcloud iam service-accounts keys create pruthvi-text-to-speech.json --iam-account=pruthvi-text-to-speech@on-prem-381812.iam.gserviceaccount.com

export GOOGLE_APPLICATION_CREDENTIALS=tts-qwiklab.json



touch synthesize-text.json

nano synthesize-text.json

## PASTE below config to json file this is body for API request

{
    'input':{
        'text':'Cloud Text-to-Speech API allows developers to include
           natural-sounding, synthetic human speech as playable audio in
           their applications. The Text-to-Speech API converts text or
           Speech Synthesis Markup Language (SSML) input into audio data
           like MP3 or LINEAR16 (the encoding used in WAV files).'
    },
    'voice':{
        'languageCode':'en-gb',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
        'audioEncoding':'MP3'
    }
}
  
## Enable the speech API  
gcloud services enable texttospeech.googleapis.com
  
## API POST request

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-text.json "https://texttospeech.googleapis.com/v1/text:synthesize" \
  > synthesize-text.txt
  
## Create file

tts_decode.py

nano tts_decode.py

## PASTE below config

import argparse
from base64 import decodebytes
import json
"""
Usage:
        python tts_decode.py --input "synthesize-text.txt" \
        --output "synthesize-text-audio.mp3"
"""
def decode_tts_output(input_file, output_file):
    """ Decode output from Cloud Text-to-Speech.
    input_file: the response from Cloud Text-to-Speech
    output_file: the name of the audio file to create
    """
    with open(input_file) as input:
        response = json.load(input)
        audio_data = response['audioContent']
        with open(output_file, "wb") as new_file:
            new_file.write(decodebytes(audio_data.encode('utf-8')))
if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Decode output from Cloud Text-to-Speech",
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--input',
                       help='The response from the Text-to-Speech API.',
                       required=True)
    parser.add_argument('--output',
                       help='The name of the audio file to create',
                       required=True)
    args = parser.parse_args()
    decode_tts_output(args.input, args.output)

## This decodes the audio file

python tts_decode.py --input "synthesize-text.txt" --output "synthesize-text-audio.mp3"

## create Index.html

<html>
  <body>
  <h1>Cloud Text-to-Speech codelab</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  </body>
</html>

## Listen to Audio

python -m http.server 8080

## Create synthetic speech from SSML

touch synthesize-ssml.json

nano synthesize-ssml.json

## Paste the config below int file

{
    'input':{
        'ssml':'<speak><s>
           <emphasis level="moderate">Cloud Text-to-Speech API</emphasis>
           allows developers to include natural-sounding
           <break strength="x-weak"/>
           synthetic human speech as playable audio in their
           applications.</s>
           <s>The Text-to-Speech API converts text or
           <prosody rate="slow">Speech Synthesis Markup Language</prosody>
           <say-as interpret-as=\"characters\">SSML</say-as>
           input into audio data
           like <say-as interpret-as=\"characters\">MP3</say-as> or
           <sub alias="linear sixteen">LINEAR16</sub>
           <break strength="weak"/>
           (the encoding used in
           <sub alias="wave">WAV</sub> files).</s></speak>'
    },
    'voice':{
        'languageCode':'en-gb',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
        'audioEncoding':'MP3'
    }
}

## SEND THE POST REQUEST

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-ssml.json "https://texttospeech.googleapis.com/v1/text:synthesize" \
  > synthesize-ssml.txt
  
  
##  generate an audio file named synthesize-ssml-audio.mp3 using the tts_decode.py

python tts_decode.py --input "synthesize-ssml.txt" --output "synthesize-ssml-audio.mp3"

## EDIT INDEX.HTML WITH BELOW CODE

<html>
  <body>
  <h1>Cloud Text-to-Speech Demo</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  <p>
  Output from synthesizing SSML:
  </p>
  <audio controls>
    <source src="synthesize-ssml-audio.mp3" />
  </audio>
  </body>
</html>

## RUN WITH PORT NO

python -m http.server 8080

## Configure audio output and device profiles

## Build your request to the Text-to-Speech API

touch synthesize-with-settings.json

nano synthesize-with-settings.json

## Paste the JSON config below

{
    'input':{
        'text':'The Text-to-Speech API is ideal for any application
          that plays audio of human speech to users. It allows you
          to convert arbitrary strings, words, and sentences into
          the sound of a person speaking the same things.'
    },
    'voice':{
        'languageCode':'en-us',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
      'speakingRate': 1.15,
      'pitch': -2,
      'audioEncoding':'OGG_OPUS',
      'effectsProfileId': ['headphone-class-device']
    }
}

## POST API request

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-with-settings.json "https://texttospeech.googleapis.com/v1beta1/text:synthesize" \
  > synthesize-with-settings.txt
  
## generate an audio file named synthesize-with-settings-audio.mp3

python tts_decode.py --input "synthesize-with-settings.txt" --output "synthesize-with-settings-audio.ogg"

## EDIT INDEX.HTML WITH BELOW CODE

<html>
  <body>
  <h1>Cloud Text-to-Speech Demo</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  <p>
  Output from synthesizing SSML:
  </p>
  <audio controls>
    <source src="synthesize-ssml-audio.mp3" />
  </audio>
  </body>
  <p>
  Output with audio settings:
  </p>
  <audio controls>
    <source src="synthesize-with-settings-audio.ogg" />
  </audio>
</html>

##  Python HTTP server

python -m http.server 8080


