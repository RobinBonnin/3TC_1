from flask import Flask, url_for, redirect, render_template, request

app = Flask(__name__)

@app.route('/hello.txt')
def hello():
  return redirect(url_for('static', filename='hello.txt'))
  
@app.route('/truth')
def truth():
	return render_template('truth.html', title='The truth', truth=42)
	
@app.route('/contacts')
def contacts():
  data = [
    {'name': 'Mr Bean', 'email': 'mrbean@outlook.com'},
    {'name': 'John Appleseed', 'email': 'john.appleseed@icloud.com'}
  ]
  return render_template('contacts.html', data=data)
  
posts = []

@app.route('/')
@app.route('/index')
def index():
  return render_template('index.html', posts=posts)

@app.route('/post', methods=['POST'])
def post():
  posts.append(request.form['post'])
  return redirect(url_for('index'))

if __name__ == '__main__':
  app.run(debug=True)
