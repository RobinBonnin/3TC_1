

# ............................................................................................... #

from flask  import *
from sqlalchemy import *
from markdown import markdown
import os, hashlib

# ............................................................................................... #

app = Flask(__name__)
app.secret_key = os.urandom(256)        

SALT = 'foo#BAR_{baz}^666'              

# ............................................................................................... #

engine = create_engine('sqlite:///wiki.db', echo=True)
metadata = MetaData()

accounts = Table('accounts', metadata,
    Column('login', String, primary_key=true),
    Column('password_hash', String, nullable=False))    

pages = Table('pages', metadata,
    Column('name', String, primary_key=true),
    Column('text', String))

metadata.create_all(engine)

def page_content(name):
    db = engine.connect()
    try:
        row = db.execute(select([pages.c.text]).where(pages.c.name == name)).fetchone()
        if row is None:
            return '**(This page is empty or does not exist.)**'
        return row[0]
    finally:
        db.close()

def update_page(name, text):
	db = engine.connect()
	try: 
		if db.execute(select([pages.c.name]).where(pages.c.name == name)).fetchone() is None:
			db.execute(pages.insert().values(name=name, text=text)) ###
		else:
			db.execute(pages.update().values(text=text).where(pages.c.name == name))
	finally:
		db.close()
			           

def hash_for(password):
    salted = '%s @ %s' % (SALT, password)
    return hashlib.sha256(salted).hexdigest()       

def authenticate_or_create(login, password): 
    db = engine.connect()
    try:
		row = db.execute(select([accounts.c.login]).where(accounts.c.login == login)).fetchone()
		if row is None:
			account_ins = accounts.insert()
			db.execute(account_ins.values(login=login,password_hash=hash_for(password)))
			return True
		else:
			sel = select([accounts]).where(and_(accounts.c.login == login,accounts.c.password_hash == hash_for(password)))
			return db.execute(sel).fetchone() != None
    finally:
		db.close()

# ............................................................................................... #

@app.route('/')
@app.route('/<name>')
def index(name='Main'):
    return redirect('/pages/' + name)

@app.route('/pages/<name>')
def page(name):
    raw = page_content(name)
    content = markdown(raw)
    return render_template('page.html', name=name, text=content, raw=raw)

@app.route('/save', methods=['POST'])
def save():
	  page = request.form['page']
	  text = request.form['text']
	  update_page(page,text)
	  return redirect('/pages/' + page)
	  
@app.route('/login', methods=['GET', 'POST'])
def login():
	from_page = request.args.get('from', 'Main')
	if request.method == 'POST':
		if authenticate_or_create(request.form['login'],request.form['password']):
			session['username'] = request.form['login']
			return redirect('/pages/' + from_page)
		else: 
			flash('Invalid password for login :' + request_form['login'])
			return retdirect('/login?from=' + from_page)
	else: 
		return render_template('login.html', from_page=from_page)        

@app.route('/logout')
def logout():
    from_page = request.args.get('from', 'Main')
    session.clear()
    return redirect('/pages/' + from_page)

# ............................................................................................... #

if __name__ == '__main__':
    app.run(debug=True)

# ............................................................................................... #

