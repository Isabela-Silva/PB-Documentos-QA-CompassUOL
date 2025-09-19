from pymongo import MongoClient
from robot.api.deco import keyword

client = MongoClient('mongodb+srv://isadev:Dev%403475@isadev.6px78fd.mongodb.net/?retryWrites=true&w=majority&appName=isadev')

db = client['isadb'] 
# qualquer coisa, tenta isadb
# deu certo <3 

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)


@keyword('Insert user from database')
def insert_user(user):
    # doc = {
    #     'name': name,
    #     'email': email,
    #     'password': password
    # }

    users = db['users']
    users.insert_one(user)
    print(user)