from flask import *

app = Flask(__name__)
app.secret_key = 'iswuygdedgv{&75619892__01;;>..zzqwQIHQIWS'  

@app.route('/')
def index():
  logged = 'logged' in session                                
  if logged:
    txt = 'Bonjour %s !' % session['name']
  else:
    txt = 'Bonjour illustre inconnu !'
  return render_template('index2.html', message=txt, logged=logged)

@app.route('/login', methods=['POST'])
def login():
  session['name'] = escape(request.form['name'])              
  session['logged'] = True
  return redirect('/')

@app.route('/logout')
def logout():
  session.clear()
  return redirect('/')

if __name__ == '__main__':
  app.run(debug=True)
