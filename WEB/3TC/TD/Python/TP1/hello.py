from flask import Flask, request, url_for, redirect, abort
app = Flask(__name__)
app.logger.debug('Bug au lancement de l\'app')


@app.route('/')       
def hey():
  app.logger.warning('Attention !')
  return 'Zog zog zog'  
 
@app.route('/excellence')
def Stan():
	app.logger.error('Mauvaise page')
	return 'Stanford' 
	
@app.route('/user/<name>')
def user(name):
  return 'User: %s' % name

@app.route('/profile/<int:uid>/<action>')
def profile(uid, action):
  return 'UID: %d / Action: %s' % (uid, action)
  
@app.route('/plop', methods=['GET', 'POST'])
def plop():
  if request.method == 'GET':       
    return "Ceci fut un HTTP GET"
  else:
    return "Ceci fut un HTTP POST"
    
@app.route('/show-routes')
def show_routes():
  routes = ''
  with app.test_request_context():
    routes = routes + url_for('Stan') + '\n'
    routes = routes + url_for('plop')
    routes = routes + url_for('Stan', aeres=True) + '\n'
    routes = routes + url_for('profile', uid=1234, action='save') + '\n'
  return routes
  
@app.route('/vortex')
def vortex():
  return redirect(url_for('Stan', code=302))

@app.route('/fail')
def fail():
  abort(500)
  
@app.errorhandler(404)
def internal_error(error):
  return "Wooops! Page inexistante"



if __name__ == '__main__':
  app.run(debug=True)


