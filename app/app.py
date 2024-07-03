from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def home():
    response = requests.get('https://api.chucknorris.io/jokes/random')
    joke = response.json()['value']
    return render_template('index.html', joke=joke)

if __name__ == '__main__':
    app.run(debug=True)