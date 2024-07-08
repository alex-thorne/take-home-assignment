from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def index():
    joke = get_chuck_norris_joke()
    return render_template('index.html', joke=joke)

def get_chuck_norris_joke():
    response = requests.get('https://api.chucknorris.io/jokes/random')
    return response.json().get('value')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)