from sqlalchemy import *
from sqlalchemy.sql import *

engine = create_engine('sqlite:///mydb', echo=True)   

metadata = MetaData()                                     

users = Table('users', metadata,                          
            Column('id', Integer, autoincrement=True, primary_key=True),
            Column('name', String))

emails = Table('emails', metadata,
            Column('id', Integer, autoincrement=True, primary_key=True),
            Column('uid', None, ForeignKey('users.id')),
            Column('email', String, nullable=False))

metadata.create_all(engine)                               
connection = engine.connect()  
                           
u_ins = users.insert()

connection.execute(u_ins.values(name='Julien'))
connection.execute(u_ins.values(name='Mr Bean'))

connection.execute(emails.insert(), [
    {'uid': 1, 'email': 'julien.ponge@insa-lyon.fr'},
    {'uid': 1, 'email': 'julien.ponge@inria.fr'},
    {'uid': 2, 'email': 'mrbean@outlook.com'}
])

